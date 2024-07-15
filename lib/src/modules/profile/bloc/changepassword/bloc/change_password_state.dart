import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:smart_sense/src/models/login_model.dart';


class ChangePasswordState extends Equatable {
  final Password password;
  final Password confPassword;
  final FormzStatus status;
  final String? errorMessage;

  const ChangePasswordState(
      {this.password =const Password.pure(),
      this.confPassword = const Password.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage = ''});

  ChangePasswordState copyWith({
    Password? password,
    Password? confPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
        password: password ?? this.password,
        confPassword: confPassword ?? this.confPassword,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [password, confPassword, status, errorMessage];
}
