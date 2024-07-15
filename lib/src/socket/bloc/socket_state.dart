abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketDisconnected extends SocketState {}

class AlertNotificationState extends SocketState {
  final Map<String, dynamic> data;
  AlertNotificationState(this.data);
}