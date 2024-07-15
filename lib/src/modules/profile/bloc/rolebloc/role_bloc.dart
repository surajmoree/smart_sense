// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:smart_sense/config.dart';

import '../../../../repositories/staff_data_repository.dart';
import 'role_event.dart';
import 'role_state.dart';


/*
class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super( const RoleState()) {
  on<FetchRoles>(_getRoleData);
  }
final StaffDataRepository staffDataRepository = StaffDataRepository();

Future<void>  _getRoleData(FetchRoles event, Emitter<RoleState> emit) async
{
  emit(state.copyWith(status: RoleStatus.initial));
  try{
    final String? token = await storage.read(key: 'token');

    final siteId = siteIdNotifier.siteId;
print('Token: $token');
      print('Site ID in roleBloc: $siteId');
      if (token == null || siteId == null) {
        // Emit failure state if token or site ID is not available
        emit(state.copyWith(status: RoleStatus.failure));
        return;
      }

      final result = await staffDataRepository.getRoleData(siteId: siteId, token: token);

     emit(state.copyWith(status: RoleStatus.success,rolelist: [...result],));



  }
  catch(e)
  {
     print('Failed to fetch role data: $e');
      emit(state.copyWith(status:  RoleStatus.failure));
  }

}

}
*/

/*
class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(const RoleState()) {
    on<FetchRoles>(_getRoleData);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();

  Future<void> _getRoleData(FetchRoles event, Emitter<RoleState> emit) async {
    emit(state.copyWith(status: RoleStatus.loading));
    try {
      final String? token = await storage.read(key: 'token');
      final siteId = event.siteId;

      print('Token: $token');
      print('Site ID in roleBloc: $siteId');
      if (token == null || siteId == null) {
        emit(state.copyWith(status: RoleStatus.failure));
        return;
      }

      final result = await staffDataRepository.getRoleData(siteId: siteId, token: token);
      emit(state.copyWith(status: RoleStatus.success, rolelist: result));
    } catch (e) {
      print('Failed to fetch role data: $e');
      emit(state.copyWith(status: RoleStatus.failure));
    }
  }
}
*/


class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(const RoleState()) {
    on<FetchRoles>(_getRoleData);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();

  Future<void> _getRoleData(FetchRoles event, Emitter<RoleState> emit) async {
    emit(state.copyWith(status: RoleStatus.loading));
    try {
      final String? token = await storage.read(key: 'token');
      final String siteId = event.siteId;

      print('Token: $token');
      print('Site ID in RoleBloc: $siteId');

      if (token == null || siteId == 0) {
        emit(state.copyWith(status: RoleStatus.failure));
        return;
      }

      final result = await staffDataRepository.getRoleData(
        siteId: siteId,
        token: token,
      );

      emit(state.copyWith(status: RoleStatus.success, rolelist: result));
    } catch (e) {
      print('Failed to fetch role data: $e');
      emit(state.copyWith(status: RoleStatus.failure));
    }
  }
}
