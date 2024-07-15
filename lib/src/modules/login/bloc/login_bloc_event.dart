/*
class LoginBlocEvent {}

class EmailUpdate extends LoginBlocEvent{
  final String email;

  EmailUpdate(this.email);
}

class PasswordUpdate extends LoginBlocEvent
{
  final String password;

  PasswordUpdate(this.password);
  
}

class StatusUpdate extends LoginBlocEvent
{
  final String status;

  StatusUpdate(this.status);

}

class ErrorUpdate extends LoginBlocEvent
{
  final String? error;

  ErrorUpdate(this.error);
  
}


class SubmitLoginForm extends LoginBlocEvent{}

*/

import 'package:equatable/equatable.dart';

abstract class LoginBlocEvent extends Equatable{
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class EmailUpdate extends LoginBlocEvent
{
  final String email;

  const EmailUpdate(this.email);

  @override
  List<Object> get props => [email];
  
}

class PasswordUpdate extends LoginBlocEvent
{
  final String password;

  const PasswordUpdate(this.password);
    @override
  List<Object> get props => [password];
}

class StatusUpdate extends LoginBlocEvent{}

class ErrorUpdate extends LoginBlocEvent
{
  final String error;

  const ErrorUpdate(this.error);
   @override
  List<Object> get props => [error];
}

class SubmitLoginForm extends LoginBlocEvent{}

class LogOutEvent extends LoginBlocEvent{}