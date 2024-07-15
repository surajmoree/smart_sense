// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_sense/src/repositories/staff_data_repository.dart';

import '../../../../models/staff_model.dart';

part 'home_page_bloc_event.dart';
part 'home_page_bloc_state.dart';

/*
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {
    on<FetchStaffDataEvent>(_fetchStaffData);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> _fetchStaffData(
      FetchStaffDataEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StaffStatus.loading));
    
    String? token = await storage.read(key: 'token');
    if (token == null) {
      emit(state.copyWith(status: StaffStatus.failure));
      return;
    }

    Map<String, String> jsonData = {'token': token};

    try {
      final result = await staffDataRepository.getStaffdata(jsonData);
      if (result != null && result.isNotEmpty) {
        emit(state.copyWith(
          status: StaffStatus.success,
          listStaff: result
              .map<StaffModel>((jsonData) => StaffModel.fromJson(jsonData))
              .toList(),
        ));
      } else {
        emit(state.copyWith(status: StaffStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: StaffStatus.failure));
    }
  }
}
*/

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<FetchStaffDataEvent>(_fetchStaffData);
  }

  final StaffDataRepository staffDataRepository = StaffDataRepository();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> _fetchStaffData(FetchStaffDataEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StaffStatus.loading));
    // ignore: avoid_print
    print('Fetching token from storage'); 
    String? token = await storage.read(key: 'token');
    

    if (token == null) {
      emit(state.copyWith(status: StaffStatus.failure));
      return;
    }

    Map<String, String> jsonData = {'token': token};

    try {
      final result = await staffDataRepository.getStaffdata(jsonData);
      final int? id = result.id;

      print('-------------profile idsss $id');
    
    
      // ignore: avoid_print
      print('Fetched data: $result'); 
      if (result != null) {
        emit(state.copyWith(
          status: StaffStatus.success,
          listStaff: [result],
        ));
      } else {
        emit(state.copyWith(status: StaffStatus.failure));
      }
    } catch (e) {
      print('Error in _fetchStaffData: $e'); 
      emit(state.copyWith(status: StaffStatus.failure));
    }
  }
}
