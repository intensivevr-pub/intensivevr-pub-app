part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordConfirmation = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Password passwordConfirmation;
  final Email email;

  RegisterState copyWith({
    FormzStatus status,
    Username username,
    Password password,
    Password passwordConfirmation,
    Email email,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, email, passwordConfirmation];
}
