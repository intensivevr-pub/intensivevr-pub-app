part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
    this.username,
    this.password,
    this.email, {
    this.status = FormzStatus.pure,
    this.error,
    this.passwordConfirmation = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Password passwordConfirmation;
  final Email email;
  final RegisterError error;

  RegisterState copyWith({
    FormzStatus status,
    Username username,
    Password password,
    Password passwordConfirmation,
    Email email,
    RegisterError error,
  }) {
    return RegisterState(
      username ?? this.username,
      password ?? this.password,
      email ?? this.email,
      status: status ?? this.status,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, email, passwordConfirmation, error];
}
