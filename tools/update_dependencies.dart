import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) async {
  final dryRun = args.contains('--dry-run');
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('❌ pubspec.yaml not found.');
    return;
  }

  final lines = await pubspecFile.readAsLines();
  final updatedLines = [...lines];

  final sectionIndexes = {
    'dependencies': _sectionIndexes(lines, 'dependencies'),
    'dev_dependencies': _sectionIndexes(lines, 'dev_dependencies'),
    'dependency_overrides': _sectionIndexes(lines, 'dependency_overrides'),
  };

  final allDeclaredPackages = {
    ...sectionIndexes['dependencies']!,
    ...sectionIndexes['dev_dependencies']!,
    ...sectionIndexes['dependency_overrides']!,
  };

  final originalVersions = <String, String?>{};
  for (var entry in allDeclaredPackages.entries) {
    final match = RegExp(r'^\s{2}${entry.key}:\s*\^?([^\s]+)')
        .firstMatch(lines[entry.value]);
    originalVersions[entry.key] = match?.group(1);
  }

  final updated = <String, String>{};

  // Step 1: Update all declared packages to latest
  for (final pkg in allDeclaredPackages.keys) {
    if (_isFlutterPackage(pkg)) continue;

    final latest = await _fetchLatestPubVersion(pkg);
    if (latest != null) {
      final index = allDeclaredPackages[pkg]!;
      updatedLines[index] = '  $pkg: ^$latest';
      updated[pkg] = latest;
    }
  }

  // Step 2: Find used but undeclared packages
  final projectName = _getProjectName(lines);
  final usedPackages = await _findUsedPackages(
    'lib',
    exclude: {
      projectName,
      ...allDeclaredPackages.keys.toSet(),
    },
  );

  for (final pkg in usedPackages) {
    if (_isFlutterPackage(pkg)) continue;
    final latest = await _fetchLatestPubVersion(pkg);
    if (latest != null) {
      final depIndex =
          updatedLines.indexWhere((line) => line.trim() == 'dependencies:');
      updatedLines.insert(depIndex + 1, '  $pkg: ^$latest');
      updated[pkg] = latest;
      print('➕ Added $pkg: ^$latest');
    } else {
      print('⚠️  Could not fetch version for $pkg');
    }
  }

  // Step 3: Suggest unused packages for removal
  final actuallyUsed = await _findUsedPackages(
    'lib',
    exclude: {projectName},
  );

  final unused = sectionIndexes['dependencies']!.keys.where((pkg) {
    final isUsed = actuallyUsed.contains(pkg);
    final isFlutter = _isFlutterPackage(pkg);
    if (!isUsed && !isFlutter) {
      print('🧹 $pkg appears unused (not imported anywhere)');
      return true;
    }
    return false;
  }).toList();

  if (unused.isNotEmpty) {
    print('\n🧹 Unused packages detected (consider removing):');
    for (final pkg in unused) {
      print('  • $pkg');
    }

    for (final pkg in unused) {
      final index = sectionIndexes['dependencies']![pkg];
      if (index != null) {
        updatedLines.removeAt(index);
        print('❌ Removed unused dependency: $pkg');
      }
    }
  }

  // Step 4: Output changelog
  if (updated.isNotEmpty) {
    print('\n📝 Changelog (updated or added):');
    updated.forEach((pkg, latest) {
      final old = originalVersions[pkg];
      if (old == null) {
        print('  • $pkg → ^$latest (new)');
      } else if (old != latest) {
        print('  • $pkg: ^$old → ^$latest');
      }
    });
  }

  if (dryRun) {
    print('\n🧪 Dry run: no changes written.');
    return;
  }

  await pubspecFile.writeAsString(updatedLines.join('\n'));
  print('\n✅ pubspec.yaml updated.');

  print('\n🚀 Running `flutter pub get`...');
  final flutterCmd = Platform.isWindows ? 'flutter.bat' : 'flutter';
  final get = await Process.run(flutterCmd, ['pub', 'get'], runInShell: true);
  stdout.write(get.stdout);
  stderr.write(get.stderr);
}

// Helpers

String _getProjectName(List<String> lines) {
  final match =
      RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(lines.join('\n'));
  return match?.group(1) ?? '';
}

bool _isFlutterPackage(String pkg) {
  const flutterBuiltIns = {
    'flutter',
    'flutter_test',
    'flutter_localizations',
    'cupertino_icons',
  };
  return flutterBuiltIns.contains(pkg);
}

Future<String?> _fetchLatestPubVersion(String package) async {
  try {
    final response =
        await http.get(Uri.parse('https://pub.dev/api/packages/$package'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['latest']['version'] as String?;
    }
  } catch (_) {}
  return null;
}

Future<Set<String>> _findUsedPackages(String dir,
    {required Set<String> exclude}) async {
  final used = <String>{};

  await for (var entity in Directory(dir).list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = await entity.readAsLines();
      for (final line in content) {
        final match =
            RegExp(r'''import\s+['"]package:([^/]+)''').firstMatch(line);
        if (match != null) {
          final pkg = match.group(1)!;
          if (!exclude.contains(pkg) && !_isFlutterPackage(pkg)) {
            used.add(pkg);
          }
        }
      }
    }
  }

  return used;
}

Map<String, int> _sectionIndexes(List<String> lines, String section) {
  final index = lines.indexWhere((line) => line.trim() == '$section:');
  if (index == -1) return {};
  final result = <String, int>{};

  for (int i = index + 1; i < lines.length; i++) {
    final match = RegExp(r'^\s{2}([a-zA-Z0-9_]+):').firstMatch(lines[i]);
    if (match != null) {
      result[match.group(1)!] = i;
    } else if (lines[i].trim().isEmpty || !lines[i].startsWith(' ')) {
      break;
    }
  }

  return result;
}
