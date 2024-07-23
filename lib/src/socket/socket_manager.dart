// ignore_for_file: avoid_print
// ignore: library_prefixes
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../main.dart';

class SocketManager {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onAlertNotification;

  void connectSocket() {
    socket = IO.io('http://192.168.0.189:5001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.connect();

    socket.onConnect((_) {
      print('Connected to the server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

    socket.on('connect_error', (error) {
      print('Connection Error: $error');
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });

    socket.on('alert_notification', (data) {
      if (onAlertNotification != null) {
        onAlertNotification!(data);
        print(data);
      }
      _showNotification(data);
    });

    socket.emit('your_custom_event', {'message': 'Hello, server!'});
  }

  Future<void> _showNotification(Map<String, dynamic> data) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alert_channel', // channelId
      'Alert Notifications', // channelName
      channelDescription: 'This channel is used for alert notifications.', // channelDescription
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Alert',
      'Alert Type: ${data['alert_type']}\nDevice: ${data['Device']}',
      platformChannelSpecifics,
      payload: jsonEncode(data),
    );
  }

  

  void dispose() {
    socket.dispose();
  }
}






/*
class SocketManager {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onAlertNotification;

  void connectSocket() {
    // Define the URL without specifying a port if the default port is being used
    const String url = 'https://tdapi.thermalcode.com/';
    print('Connecting to: $url');

    // Create and configure the socket
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Attempt to connect
    socket.connect();

    // Handle connection events
    socket.onConnect((_) {
      print('Connected to the server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

    // Handle connection errors
    socket.on('connect_error', (error) {
      print('Connection Error: $error');
      if (error is WebSocketException) {
        print('WebSocketException: ${error.message}');
      }
    });

    // Handle socket errors
    socket.on('error', (error) {
      print('Socket error: $error');
    });

    // Handle custom event
    socket.on('alert_notification', (data) {
      if (onAlertNotification != null) {
        onAlertNotification!(data);
        print(data);
      }
    });

    // Emit a custom event
    socket.emit('your_custom_event', {'message': 'Hello, server!'});
  }
    void dispose() {
    socket.dispose();
  }
}

*/















/*
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onAlertNotification;

  void connectSocket() {
    socket = IO.io(
      'https://tdapi.thermalcode.com:8001',
      IO.OptionBuilder()
          .setTransports([ 'polling']) //'websocket', 
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('Connected to the server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

    socket.on('connect_error', (error) {
      print('Connection Error: $error');
    });

    socket.on('error', (error) {
      print('Socket Error: $error');
    });

    socket.on('alert_notification', (data) {
      if (onAlertNotification != null) {
        onAlertNotification!(data);
        print(data);
      }
    });

    socket.emit('your_custom_event', {'message': 'Hello, server!'});
  }

  void dispose() {
    socket.dispose();
  }
}
*/
