import 'package:dartz/dartz.dart' as dartz;
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/network_utils/network_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  final String socketUrl = '${NetworkUtils.baseUrl}chat';
  IO.Socket? socket;
  final List<dartz.Tuple2<String, Function(dynamic)>> listeners;

  SocketHelper(this.listeners);

  void init() {
    // Initialize the socket with options
    socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Use WebSocket transport
          .disableAutoConnect() // Set autoConnect to false
          .setExtraHeaders({
            'Authorization': 'Bearer ${CachingUtils.token ?? ''}',
          }) // Add extra headers
          .build(),
    );

    // Connect the socket
    socket!.connect();

    // Socket event handlers
    socket!.on('connect', (_) {
      print('connected');
    });

    // Add custom event listeners
    for (var listener in listeners) {
      socket!.on(listener.value1, listener.value2);
    }

    socket!.on('disconnect', (_) {
      print('disconnected');
    });

    socket!.on('error', (data) {
      print('error: $data');
    });
  }

  void close() {
    // Disconnect and clean up the socket
    socket?.disconnect();
    socket?.close();
  }
}
