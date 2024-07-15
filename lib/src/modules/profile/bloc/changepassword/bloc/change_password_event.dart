import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordUpdate extends ChangePasswordEvent {
  final String password;

  const PasswordUpdate(this.password);
  @override
  List<Object> get props => [password];
}

class ConfirmPassUpdate extends ChangePasswordEvent {
  final String confirmPass;

  const ConfirmPassUpdate(this.confirmPass);
  @override
  List<Object> get props => [confirmPass];
}



class StatusUpdate extends ChangePasswordEvent {
 

  
}

class ErrorUpdate extends ChangePasswordEvent {
  final String error;

  const ErrorUpdate(this.error);
  @override
  List<Object> get props => [error];
}

class UpdateForm extends ChangePasswordEvent {
   final String id;

  UpdateForm({required this.id});

}
