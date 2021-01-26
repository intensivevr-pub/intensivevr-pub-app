import 'package:formz/formz.dart';

enum UsernameValidationError { empty,duplicate}

class Username extends FormzInput<String, UsernameValidationError> {
  Username.pure() : super.pure('');
  Username.dirty([String value = '']) :isDuplicate = false, super.dirty(value);
  bool isDuplicate = false;

  @override
  UsernameValidationError validator(String value) {
    if(value.isEmpty){
      return UsernameValidationError.empty;
    }
    if(isDuplicate){
      return UsernameValidationError.duplicate;
    }
    return null;
  }
}
