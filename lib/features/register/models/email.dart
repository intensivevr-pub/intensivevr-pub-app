import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

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
        return 'form_errors.email_empty'.tr();
        break;
      case EmailValidationError.bad:
        return 'form_errors.email_incorrect'.tr();
        break;
      case EmailValidationError.duplicate:
        return 'form_errors.duplicate_email'.tr();
        break;
    }
    return null;
  }
}
