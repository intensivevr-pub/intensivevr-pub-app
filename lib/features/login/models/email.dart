import 'package:formz/formz.dart';

enum EmailValidationError { empty, bad }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    ).hasMatch(value.trim())) return EmailValidationError.bad;
  }

  String getErrorMessage() {
    switch (error) {
      case EmailValidationError.empty:
        return "Email nie może być pusty";
        break;
      case EmailValidationError.bad:
        return "To nie jest poprawny email";
        break;
    }
    return null;
  }
}
