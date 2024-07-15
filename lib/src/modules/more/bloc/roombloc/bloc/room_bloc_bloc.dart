// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:smart_sense/config.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';

import '../../../../../repositories/staff_data_repository.dart';
import 'room_bloc_event.dart';
import 'room_bloc_state.dart';


class RoomBloc extends Bloc<RoomEvent, Roomstate> {
  RoomBloc() : super(const Roomstate())
  {
    on<FetchPage>(_fetchStaffRoom);
  }
  final StaffDataRepository staffDataRepository = StaffDataRepository();
  Future<void> _fetchStaffRoom(FetchPage event, Emitter<Roomstate> emit)async
  {
    emit(state.copyWith(status: RoomStatus.loading));
    try{
      String? token = await storage.read(key: 'token');
      final siteId = siteIdNotifier.siteId;

       print('Token: $token');
      print('Site ID in Zone: $siteId');

    if(token == null || siteId == null )
    {
      emit(state.copyWith(status: RoomStatus.failure ));
      return;
    }

    final result = await staffDataRepository.getRoomData(page: event.page, siteId: siteId, token: token);

    emit(state.copyWith(status: RoomStatus.success,
    roomlist: [...state.roomlist, ...result],
    totalCount: state.totalCount + result.length,
    ));
    }catch(e)
    {
      print('Failed to fetch staff zone data: $e');
      emit(state.copyWith(status: RoomStatus.failure));
    }
  }

}
                                                    
