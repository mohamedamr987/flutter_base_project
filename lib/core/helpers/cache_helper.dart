import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheHelper {
  final Queue<_QueueItem> _queue =
      Queue<_QueueItem>(); // Queue to store URL and Completer
  bool _isProcessing =
      false; // Flag to track whether a URL is currently being processed

  // Singleton pattern (optional)
  static final CacheHelper _instance = CacheHelper._internal();
  factory CacheHelper() => _instance;
  CacheHelper._internal();

  // Method to add a URL to the queue and return a Future<File>
  Future<File> addToQueue(String url) async {
    // Create a completer to handle the result of the URL processing
    Completer<File> completer = Completer<File>();

    // Add the URL and completer as a _QueueItem to the queue
    _queue.add(_QueueItem(url, completer));

    // Start processing the queue if not already processing
    await _processNext();

    // Return the future that will complete when the file is downloaded
    return completer.future;
  }

  // Method to process the next item in the queue
  Future<void> _processNext() async {
    if (_isProcessing || _queue.isEmpty)
      return; // Exit if already processing or queue is empty

    _isProcessing = true; // Mark as processing

    // Get the next item in the queue
    _QueueItem item = _queue.removeFirst();

    try {
      // Process the URL (fetch the file)
      File file = await _processUrl(item.url);

      // Complete the completer with the downloaded file
      item.completer.complete(file);
    } catch (e) {
      // Complete with an error if something goes wrong
      item.completer.completeError(e);
    }

    _isProcessing = false; // Mark as not processing

    // After completing, check if there's more to process
    if (_queue.isNotEmpty) {
      await _processNext(); // Process the next URL in the queue
    }
  }

  // Method to process a URL and fetch the file from cache
  Future<File> _processUrl(String url) async {
    print("Processing URL: $url");

    // Example using DefaultCacheManager to fetch the file
    final file = await DefaultCacheManager().getSingleFile(url);

    print("Downloaded file: ${file.path}");
    return file;
  }
}

// Helper class to store the URL and Completer together in the queue
class _QueueItem {
  final String url;
  final Completer<File> completer;

  _QueueItem(this.url, this.completer);
}
