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
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _UsernameInput(),
          _PasswordInput(),
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
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CredentialInput(
          hint: "Username",
          labelText: "Username",
          errorText: state.username.invalid ? 'invalid username' : null,
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
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
          hint: "password",
          labelText: "password",
          errorText: state.password.invalid ? 'invalid password' : null,
          onChanged: (password) =>
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
                border: Border.all(),
                padding: EdgeInsets.all(16),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0),
                splashColor: Colors.purple,
                text: Text(
                  "Zaloguj się",
                  style: TextStyle(color: Colors.black),
                ));
      },
    );
  }
}
