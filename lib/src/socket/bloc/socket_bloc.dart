
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sense/src/socket/socket_manager.dart';

import 'socket_event.dart';
import 'socket_state.dart';
class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final SocketManager socketManager;

  SocketBloc(this.socketManager) : super(SocketInitial()) {
    on<ConnectSocket>((event, emit) {
      socketManager.connectSocket();
      socketManager.onAlertNotification = (data) {
        add(AlertNotificationReceived(data));
        print(data);
      };
      emit(SocketConnected());
    });

    on<DisconnectSocket>((event, emit) {
      socketManager.dispose();
      emit(SocketDisconnected());
    });

    on<AlertNotificationReceived>((event, emit) {
      emit(AlertNotificationState(event.data));
    });
  }
}