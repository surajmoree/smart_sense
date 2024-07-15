// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:smart_sense/src/models/login_model.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_event.dart';
import 'package:smart_sense/src/repositories/authenthication.dart';

import '../../../../config.dart';
import '../../../network/controller/authentication_siteId.dart';
import 'login_bloc_state.dart';

/*
class LoginBloc extends Bloc<LoginBlocEvent, LoginState> {
 // final UserApi userApi;


  LoginBloc (): super(const LoginState())
  {
     on<EmailUpdate>(_onEmailUpdate);
     on<PasswordUpdate>(_onPasswordUpdate);
     on<SubmitLoginForm>(_onSubmitLoginForm);
     on<StatusUpdate>(_onStatusUpdate);
     on<ErrorUpdate>(_onErrorUpdate);
     
  }
 

  Future<void> _onEmailUpdate( EmailUpdate event, Emitter<LoginState> emit) async
  {
   
    final email = Email.dirty(event.email );
    emit(state.copyWith(email: email,status: Formz.validate([email, state.password])));
  }

  Future<void> _onPasswordUpdate( PasswordUpdate event, Emitter<LoginState> emit)async
  {
    final password = Password.dirty(event.password );
    emit(state.copyWith(email: state.email,password: password,status: Formz.validate([state.email, password])));
  }

  Future<void> _onStatusUpdate(StatusUpdate event, Emitter<LoginState> emit) async{
    emit(state.copyWith(status: FormzStatus.pure));
  }

  Future<void> _onErrorUpdate(ErrorUpdate event, Emitter<LoginState> emit)async
  {
    emit(state.copyWith(errorMessage: event.error));
  }

  Future<void> _onSubmitLoginForm(SubmitLoginForm event, Emitter<LoginState> emit)async
{
  if(state.status.isInvalid)
  {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
  }
  try{
    Map<String,Object> jsonData = {
      "formData": jsonEncode({'email': state.email.value, 'password': state.password.value})
    };
    final result = await AuthenticationRepo().submitLoginForm(jsonData);

    if(result != null && result.containsKey('token'))
    {
     final siteId = result['site_id'];
      storage.write(key: 'token', value: result['token']);
      
      print( 'login  token : ${ result['token']}');
       print( 'login  siteId : ${ result['site_id']}');
       await siteIdNotifier.saveSiteId(siteId);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
    else{
      emit(state.copyWith(errorMessage: 'Login Failed',status: FormzStatus.submissionFailure));
    }
  }catch(e,_)
  {
    emit(state.copyWith(errorMessage: "Login Failed",status: FormzStatus.submissionFailure));
    print(e);
    print(_);
  }
}




  Future<dynamic> submitLoginForm() async
  {
    if(state.status.isInvalid)
    {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
    try{
      Map<String,Object> jsonData = 
      {
        "formData" :jsonEncode({'email':state.email.value, 'password': state.password.value})
      };

      final result = await AuthenticationRepo().submitLoginForm(jsonData);

      if(result != null && result.containsKey('token'))
      {
         storage.write(key: 'token', value: result['token']);
         print( 'this is token : ${ result['token']}');
         print( 'this is siteId : ${ result['site_id']}');
         emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
      else{
        emit(state.copyWith(errorMessage: "Login failed...",status: FormzStatus.submissionFailure));
      }
    }catch(e,_)
    {
           emit(
        state.copyWith(
            errorMessage: "Login failed...",
            status: FormzStatus.submissionFailure),
      );
       print(e);
      print(_);
    }
  }


 
}
*/

class LoginBloc extends Bloc<LoginBlocEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailUpdate>(_onEmailUpdate);
    on<PasswordUpdate>(_onPasswordUpdate);
    // on<SubmitLoginForm>(_onSubmitLoginForm);
    on<StatusUpdate>(_onStatusUpdate);
    on<ErrorUpdate>(_onErrorUpdate);
    on<LogOutEvent>(_logout);
  }
  final AuthenticationRepo authenticationRepo = AuthenticationRepo();
  Future<void> _onEmailUpdate(
      EmailUpdate event, Emitter<LoginState> emit) async {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  Future<void> _onPasswordUpdate(
      PasswordUpdate event, Emitter<LoginState> emit) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password, status: Formz.validate([state.email, password])));
  }

  Future<void> _onStatusUpdate(
      StatusUpdate event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzStatus.pure));
  }

  Future<void> _onErrorUpdate(
      ErrorUpdate event, Emitter<LoginState> emit) async {
    emit(state.copyWith(errorMessage: event.error));
  }

  Future<void> _logout(LogOutEvent event, Emitter<LoginState> emit) async {
    try {
      String? token = await storage.read(key: 'token');
      if (token != null) {
        await authenticationRepo.logout(token);
        // ignore: avoid_print
        print('--------logout token $token');
        await storage.delete(key: 'token');

        // Navigate to the login screen
        emit(state.copyWith(
            status: FormzStatus
                .submissionCanceled)); // Or any other appropriate state
      }
    } catch (e) {
      print('Error in logout: $e');
      print('--------logout failed');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<dynamic> submitLoginForm() async {
    if (state.status.isInvalid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
    try {
      Map<String, Object> jsonData = {
        "formData": jsonEncode(
            {'email': state.email.value, 'password': state.password.value})
      };

      final result = await AuthenticationRepo().submitLoginForm(jsonData);

      if (result != null && result.containsKey('token')) {
        final siteId = result['site_id'];
        await siteIdNotifier.saveSiteId(siteId);
        storage.write(key: 'token', value: result['token']);
        print('this is token : ${result['token']}');
        print('this is siteId : ${result['site_id']}');
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(
            errorMessage: "Login failed...",
            status: FormzStatus.submissionFailure));
      }
    } catch (e, _) {
      emit(
        state.copyWith(
            errorMessage: "Login failed...",
            status: FormzStatus.submissionFailure),
      );
      print(e);
      print(_);
    }
  }
}
