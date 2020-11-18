import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:intensivevr_pub/features/register/models/models.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  RegisterState _mapUsernameChangedToState(
    RegisterUsernameChanged event,
    RegisterState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username, state.email]),
    );
  }

  RegisterState _mapEmailChangedToState(
    RegisterEmailChanged event,
    RegisterState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, state.username, email]),
    );
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.email]),
    );
  }
  RegisterState _mapPasswordConfirmationChangedToState(
      RegisterPasswordConfirmationChanged event,
      RegisterState state,
      ) {
    final passwordConfirmation = Password.dirty(event.passwordConfirmation);
    FormzStatus status;
    if(passwordConfirmation == state.password){
      status = Formz.validate([state.password,passwordConfirmation, state.username, state.email]);
    }else{
      status = FormzStatus.invalid;
    }
    return state.copyWith(
      passwordConfirmation: passwordConfirmation,
      status: status,
    );
  }
  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.register(
          username: state.username.value,
          password: state.password.value,
          email: state.email.value,
        );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
