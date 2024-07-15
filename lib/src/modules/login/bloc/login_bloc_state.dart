/*
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class LoginState extends Equatable {
   const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess( this.token);

  @override
  List<Object> get props => [token];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure( this.error);

  @override
  List<Object> get props => [error];
}
*/

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../models/login_model.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  const LoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage = ''});

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
