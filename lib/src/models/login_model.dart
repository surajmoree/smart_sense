import 'package:formz/formz.dart';
enum EmailValidationError {
  
  invalid
}
class Email extends FormzInput<String, EmailValidationError> {

  const Email.pure() : super.pure('');

  
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}



enum PasswordValidationError {
  
  invalid
}

class Password extends FormzInput<String, PasswordValidationError> {
  
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(r'[A-Za-z\d]{6,}$');
  

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

/*

import 'package:formz/formz.dart';

enum EmailValidationError{invalid}

class Email extends FormzInput<String, EmailValidationError>
{
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value)
  {
    return value?.contains('@') == true ? null: EmailValidationError.invalid;
  }

}

enum PasswordValidationError{invalid}
class Password extends FormzInput<String, PasswordValidationError>
{
  const Password.pure() : super.pure('');
  const Password.dirty([String value ='']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value)
  {
    return value != null && value.length>6 ? null : PasswordValidationError.invalid;
  }
}
*/