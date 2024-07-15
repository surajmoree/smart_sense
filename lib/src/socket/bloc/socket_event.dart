abstract class SocketEvent {}

class ConnectSocket extends SocketEvent {}

class DisconnectSocket extends SocketEvent {}

class AlertNotificationReceived extends SocketEvent {
  final Map<String, dynamic> data;
  AlertNotificationReceived(this.data);
}