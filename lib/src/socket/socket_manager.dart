// ignore_for_file: avoid_print
// ignore: library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_sense/src/network/controller/authentication_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketManager {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onAlertNotification;
  final Authentication auth;
  SocketManager(this.auth);
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

    socket.on('alert_notification', (data)async {
        await auth.checkLogin();
      if (auth.loggedIn && onAlertNotification != null) {
        onAlertNotification!(data);
        print(data);
         print('login status---------------${auth.loggedIn}');
      }
     FlutterBackgroundService().invoke('alert_notification',data);
     
    });

    socket.emit('your_custom_event', {'message': 'Hello, server!'});
  }
  void dispose() {
    socket.dispose();
  }
}
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  await service.startService();
}
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  
 // DartPluginRegistrant.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    importance: Importance.max, priority: Priority.high, showWhen: false
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
 final auth = Authentication();
 await auth.checkLogin();
  final socketManager = SocketManager(auth);
  socketManager.connectSocket();
  socketManager.onAlertNotification = (data) {
    if(auth.loggedIn)
    {
    flutterLocalNotificationsPlugin.show(
      0, 'New alert', 'You have a new alert notification', platformChannelSpecifics,
      payload: 'item x',
    );
     print('login status---------------${auth.loggedIn}');
    }

  };

  service.on('alert_notification').listen((data) {
    if(auth.loggedIn)
    {
  flutterLocalNotificationsPlugin.show(
      0, 'New alert', 'You have a new alert notification', platformChannelSpecifics,
      payload: 'item x',
    );
     print('login status---------------${auth.loggedIn}');
    }
  
  });
  
}

Future<void> initializeNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
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
