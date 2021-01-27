import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intensivevr_pub/features/login/bloc/login_bloc.dart';
import 'package:intensivevr_pub/widgets/widgets.dart';

import '../../../widgets/textfields/credential_input.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: _UsernameInput(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: _PasswordInput(),
          ),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CredentialInput(
          labelText: "Email",
          errorText: state.email.invalid ? state.email.getErrorMessage() : null,
          onChanged: (String email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          fieldKey: const Key('loginForm_usernameInput_textField'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CredentialInput(
          labelText: "Hasło",
          obscure: true,
          errorText:
              state.password.invalid ? state.password.getErrorMessage() : null,
          onChanged: (String password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          fieldKey: const Key('loginForm_passwordInput_textField'),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : WelcomeButton(
                onPress: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                border: Border.all(width: 1.5),
                padding: const EdgeInsets.all(16),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color.fromRGBO(255, 255, 255, 0),
                splashColor: Colors.purple,
                text: const Text(
                  "Zaloguj się",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ));
      },
    );
  }
}
