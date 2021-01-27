import 'package:formz/formz.dart';

enum EmailValidationError { empty, bad, duplicate }

class Email extends FormzInput<String, EmailValidationError> {
  Email.pure() : super.pure('');

  Email.dirty([String value = ''])
      : isDuplicate = false,
        super.dirty(value);
  bool isDuplicate = false;
  bool isBad = false;

  @override
  EmailValidationError validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    ).hasMatch(value.trim())) return EmailValidationError.bad;
    if (isDuplicate) {
      return EmailValidationError.duplicate;
    }
    if (isBad) {
      return EmailValidationError.bad;
    }
    return null;
  }

  String getErrorMessage() {
    switch (error) {
      case EmailValidationError.empty:
        return "Email nie może być pusty";
        break;
      case EmailValidationError.bad:
        return "To nie jest poprawny email";
        break;
      case EmailValidationError.duplicate:
        return "Ten email już jest w systemie";
        break;
    }
    return null;
  }
}
