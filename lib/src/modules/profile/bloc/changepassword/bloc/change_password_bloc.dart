import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:smart_sense/src/models/login_model.dart';

import '../../../../../../config.dart';
import '../../../../../repositories/authenthication.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordState()) {
    on<PasswordUpdate>(_passwordUpdate);
    on<ConfirmPassUpdate>(_confPassUpdate);
    on<StatusUpdate>(_statusUpdate);
    on<ErrorUpdate>(_ErrorUpdate);
    on<UpdateForm>(_submitForm);
  }

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  Future<void> _passwordUpdate(
      PasswordUpdate event, Emitter<ChangePasswordState> emit) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.confPassword])));
  }

  Future<void> _confPassUpdate(
      ConfirmPassUpdate event, Emitter<ChangePasswordState> emit) async {
    final confPass = Password.dirty(event.confirmPass);
    emit(state.copyWith(
        confPassword: confPass,
        status: Formz.validate([confPass, state.password])));
  }

  Future<void> _statusUpdate(
      StatusUpdate event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(status: FormzStatus.pure));
  }

  Future<void> _ErrorUpdate(
      ErrorUpdate event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(errorMessage: event.error));
  }

  Future<void> _submitForm(UpdateForm event, Emitter<ChangePasswordState> emit) async {
    if (state.status.isInvalid) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return;
    }

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final String? token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception('Token is null');
      }

      Map<String, String> formData = {
        'formData': jsonEncode({
          // 'originalData': {
          //   'password': '',
          //   'confirm_password': ''
          // },
          'password': state.password.value,
          'confirm_password': state.confPassword.value,
        }),
        'token': token.toString()
      };

      // Log the JSON data
      print("JSON Data to be sent: $formData");

      final result = await authenticationRepo.userChangePassword(formData, []);

      // Log the response data
      print("Response from API: $result");

      if (result != null && result['status'] == 'Success') {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure,
        errorMessage: result != null? result['message']:'Unknown error'
        ));
      }
    } catch (e) {
      print("Error: $e");
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

}
