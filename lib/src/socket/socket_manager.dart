// ignore_for_file: avoid_print
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onAlertNotification;
  void connectSocket() {
    IO.Socket socket =
        IO.io('https://tdapi.thermalcode.com/', <String, dynamic>{
      'transports': ['websocket']
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

/*
  void connectSocket() {
    socket = IO.io(
      'https://tdapi.thermalcode.com',
     //'https://nms-socket-chat-dot-nms-cp01.nw.r.appspot.com/' ,
      IO.OptionBuilder()
          .setTransports(['polling'])
          .disableAutoConnect()
          .setExtraHeaders({
            'Connection': 'upgrade',
            'Upgrade': 'websocket',
          })
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
*/
  void dispose() {
    socket.dispose();
  }
}



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
