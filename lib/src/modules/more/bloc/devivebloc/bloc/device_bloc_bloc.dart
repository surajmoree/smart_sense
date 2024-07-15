// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:smart_sense/config.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';

import '../../../../../repositories/staff_data_repository.dart';
import 'device_bloc_event.dart';
import 'device_bloc_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(const DeviceState()) {
    on<FetchDataEvent>(_getDeviceData);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();

  Future<void> _getDeviceData(
      FetchDataEvent event, Emitter<DeviceState> emit) async {
    emit(state.copyWith(status: DeviceStatus.loading));
    try {
      final String? token = await storage.read(key: 'token');
      final siteId = siteIdNotifier.siteId;

      print('Token: $token');
      print('Site ID in Zone: $siteId');

      if (siteId == null || token == null) {
        emit(state.copyWith(status: DeviceStatus.failure));
        return;
      }

      final result = await staffDataRepository.getDeviceData(
          page: event.page, siteId: siteId, token: token);

      emit(state.copyWith(
        status: DeviceStatus.success,
        devicelist: [
          ...state.devicelist,
          ...result,
        ],
        totalCount: state.totalCount + result.length,
      ));
    } catch (e) {
      print('Failed to fetch staff zone data: $e');
      emit(state.copyWith(status: DeviceStatus.failure));
    }
  }
}
