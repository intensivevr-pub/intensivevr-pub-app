import 'package:formz/formz.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return null;
  }

  String getErrorMessage() {
    switch (error) {
      case EmailValidationError.empty:
        return 'form_errors.email_empty'.tr();
        break;
      case EmailValidationError.bad:
        return 'form_errors.email_incorrect'.tr();
    }
    return null;
  }
}
