import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';
import 'package:smart_sense/src/repositories/staff_data_repository.dart';

import '../../../../../config.dart';
import '../../../../models/staff_zone_model.dart';

part 'staff_zone_bloc_event.dart';
part 'staff_zone_bloc_state.dart';
/*
class StaffZoneBloc extends Bloc<StaffZoneEvent, StaffZoneState> {
  StaffZoneBloc() : super(StaffZoneState()) {
   
    
     on<FetchStaffZone>(_fetchStaffZone);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();


  Future<void> _fetchStaffZone(FetchStaffZone event, Emitter<StaffZoneState> emit) async {
    emit(state.copyWith(status: ZoneStatus.loading));
    String? token = await storage.read(key: 'token');
    final siteId = siteIdNotifier.siteId;


 print('------------------token: $token');
  print('------------------siteId: $siteId');



    if (token == null || siteId == null) {
      emit(state.copyWith(status: ZoneStatus.failure));
      return;
    }

    try {
      final result = await staffDataRepository.getZoneData(page: event.page, siteId: siteId, token: token);
       print('result--------: $result');
       
      emit(state.copyWith(
        status: ZoneStatus.success,
        zonelist: [...state.zonelist, ...result],
         
        totalCount: state.totalCount + result.length, // Adjust this logic based on your API response
      ));
      print('result--------: $result');
    } catch (e) {
      emit(state.copyWith(status: ZoneStatus.failure));
    }
  }

 
}


*/
class StaffZoneBloc extends Bloc<StaffZoneEvent, StaffZoneState> {
  StaffZoneBloc() : super(StaffZoneState()) {
   
    
     on<FetchStaffZone>(_fetchStaffZone);
     
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();


  Future<void> _fetchStaffZone(FetchStaffZone event, Emitter<StaffZoneState> emit) async {
    
    emit(state.copyWith(status: ZoneStatus.loading));
    try {
     
      String? token = await storage.read(key: 'token');
      
    final siteId = siteIdNotifier.siteId;
      // ignore: avoid_print
      print('Token: $token');
      // ignore: avoid_print
      print('Site ID in Zone: $siteId');

      if (token == null || siteId == null) {
       
        emit(state.copyWith(status: ZoneStatus.failure));
        return;
      }

      
      final result = await staffDataRepository.getZoneData(
        page: event.page,
        siteId: siteId,
        token: token,
      );

     
      emit(state.copyWith(
        status: ZoneStatus.success,
        zonelist: [...state.zonelist, ...result],
        totalCount: state.totalCount + result.length, // Adjust this logic based on your API response
      ));
    } catch (e) {
    
      // ignore: avoid_print
      print('Failed to fetch staff zone data: $e');
      emit(state.copyWith(status: ZoneStatus.failure));
    }

}




}



