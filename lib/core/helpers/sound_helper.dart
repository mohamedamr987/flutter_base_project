import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class SoundHelper {
  final record = AudioRecorder();
  AudioPlayer? player; // Using just_audio for playback
  bool isRecorderInitialized = false;
  bool _isPlayerInitialized = false;
  String? recordingPath;
  Stopwatch stopwatch = Stopwatch();

  bool isRecording = false;
  bool isRecorded = false;
  bool isPlaying = false;

  Future<void> init() async {
    player = AudioPlayer(); // Initialize just_audio player
    final status = await requestPermission();
    if (!status) return;

    isRecorderInitialized = true;

    // No need to open audio session for just_audio player
    _isPlayerInitialized = true;
  }

  Future<bool> requestPermission() async {
    print("Requesting permission");
    var status = await Permission.microphone.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.microphone.request();
      return status == PermissionStatus.granted;
    }
    print("permission granted");
    return true;
  }

  // Recording methods remain unchanged
  Future<void> startRecording() async {
    if (!isRecorderInitialized || isRecording) return;
    stopwatch.reset();
    stopwatch.start();
    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/flutter_sound_recording${DateTime.now().toString().replaceAll(" ", "_")}.mp3';
    await record.start(RecordConfig(encoder: AudioEncoder.wav), path: path);
    print("Recording started at $path");
    isRecording = true;
  }

  Future<void> stopRecording() async {
    if (!isRecorderInitialized || !isRecording) return null;

    recordingPath = await record.stop();
    isRecording = false;
    isRecorded = true;
    stopwatch.stop();
    // I want to check if the recording didn't exceed the 1 second and if yes clear it
    if (stopwatch.elapsedMilliseconds < 1000) {
      clearRecording();
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  Future<void> playRecording({bool isUrl = true}) async {
    print("_isPlayerInitialized $_isPlayerInitialized");
    print("isPlaying $isPlaying");
    print("recordingPath $recordingPath");
    if (!_isPlayerInitialized || isPlaying || recordingPath == null) return;
    try {
      isPlaying = true;

      if (player!.duration == null) {
        if (isUrl)
          await player!.setUrl(recordingPath!); // Load the recordin
        else {
          var file = File(recordingPath!);
          file.writeAsBytesSync(file.readAsBytesSync());
          await player!.setFilePath(file.path);
        }
      }

      player!.play(); // Start playback

      print("Playback started");
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stopPlaying() async {
    if (!_isPlayerInitialized || !isPlaying) return;

    player!.stop();
    isPlaying = false;
  }

  Future<void> setUrl(String path, bool isUrl) async {
    if (isUrl)
      await player!.setUrl(path);
    else
      await player!.setFilePath(path);
    recordingPath = path;
  }

  void clearRecording() {
    recordingPath = null;
    isRecording = false;
    isPlaying = false;
    player?.dispose();
    player = AudioPlayer();
    isRecorded = false;
  }

  Future<void> dispose() async {
    if (isRecorderInitialized && await record.isRecording()) {
      await record.stop();
    }

    // No need to check if playing before stopping, just_audio handles this
    await player?.dispose(); // Properly dispose of just_audio player
  }
}
