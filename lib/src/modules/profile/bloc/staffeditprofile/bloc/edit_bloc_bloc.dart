import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_sense/config.dart';

import '../../../../../models/staff_edit_profile.dart';
import '../../../../../repositories/staff_data_repository.dart';
import 'edit_bloc_event.dart';

part 'edit_bloc_state.dart';

// class EditBloc extends Bloc<EditEvent, EditState> {
//   EditBloc() : super(EditState()) {
//     on<EditStaffEvent>(_editStaffData);
//   }
//   final StaffDataRepository staffDataRepository = StaffDataRepository();

//   Future<void> _editStaffData(
//       EditStaffEvent event, Emitter<EditState> emit) async {
//     emit(state.copyWith(status: EditStatus.loading));
//     try {
//       final String? token = await storage.read(key: 'token');
//       if (token == null) {
//         emit(state.copyWith(status: EditStatus.failure));
//         return;
//       }

//       Map<String, Object> jsonData = {
//         'token': token.toString(),
//         'id': event.id.toString(),
//       };

//       final staffData = await staffDataRepository.editStaffData(jsonData);
//       print('--------------------------- edit bloc$staffData');
//       if (staffData != null) {
//         emit(state.copyWith(
//             status: EditStatus.success,
//             listdata: staffData,
//           ));

//       }
//     } catch (e) {
//       print('Error in _editStaffData: $e');
//       emit(state.copyWith(status: EditStatus.failure));
//     }
//   }

// }

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditState()) {
    on<EditStaffEvent>(_editStaffData);
    on<UpdateStaffData>(_onUpdateStaffData);
  }
  final StaffDataRepository staffDataRepository = StaffDataRepository();

  Future<void> _editStaffData(
      EditStaffEvent event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.loading));
    try {
      final String? token = await storage.read(key: 'token');
      if (token == null) {
        emit(state.copyWith(status: EditStatus.failure));
        return;
      }

      Map<String, Object> jsonData = {
        'token': token.toString(),
        'id': event.id.toString(),
      };

      final staffData = await staffDataRepository.editStaffData(jsonData);
      print('--------------------------- edit bloc$staffData');
      if (staffData.staffData != null && staffData.staffImage != null) {
        emit(state.copyWith(
          status: EditStatus.success,
          listdata: staffData,
        ));
      }
    } catch (e) {
      print('Error in _editStaffData: $e');
      emit(state.copyWith(status: EditStatus.failure));
    }
  }
   
  
   _onUpdateStaffData(UpdateStaffData event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.updating));
    final token = await storage.read(key: 'token');
    // Ensure formData contains only encodable values
    Map<String, Object> formData = { 
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    print('StaffData sent---------${formData}');

    try {
      dynamic result = await staffDataRepository.updateStaffData(formData, event.files);

      if (result['status'] == "Success") {
        emit(state.copyWith(status: EditStatus.updated));
        await Future.delayed(Duration(seconds: 1));
        emit(state.copyWith(status: EditStatus.success));
        if(event.profileImage.path.isNotEmpty)
        {

        }
      } else {
        emit(state.copyWith(status: EditStatus.failure));
      }
    } catch (e) {
      print('Error in _onUpdateStaffData: $e');
      emit(state.copyWith(status: EditStatus.failure));
    }
  }


}
