import 'package:formz/formz.dart';

enum PasswordValidationError { empty, toShort, onlyNumbers }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    if (!value.isNotEmpty) return PasswordValidationError.empty;
    if (value.length < 8) return PasswordValidationError.toShort;
    if (RegExp(r'^[0-9]*$').hasMatch(value))
      return PasswordValidationError.onlyNumbers;
    return null;
  }

  String getErrorMessage() {
    switch (error) {
      case PasswordValidationError.empty:
        return "Hasło nie może być puste";
        break;
      case PasswordValidationError.toShort:
        return "Hasło musi składać się z conajmniej 8 znaków";
        break;
      case PasswordValidationError.onlyNumbers:
        return "Hasło nie może składać się wyłącznie z cyfr";
        break;
    }
    return null;
  }
}
