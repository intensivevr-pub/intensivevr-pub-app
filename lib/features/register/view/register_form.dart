import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intensivevr_pub/features/register/bloc/register_bloc.dart';
import 'package:intensivevr_pub/widgets/buttons/welcome_button.dart';
import 'package:intensivevr_pub/widgets/textfields/credential_input.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Register Failure')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          _LoginInput(),
          _PasswordInput(),
          _ConfirmPasswordInput(),
          _DateOfBirth(),
          _TermsOfUse(),
          _RegisterButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CredentialInput(
          labelText: "Email",
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
          fieldKey: const Key('registerForm_emailInput_textField'),
        );
      },
    );
  }
}

class _LoginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CredentialInput(
          labelText: "Username",
          errorText: state.username.invalid ? 'invalid username' : null,
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username)),
          fieldKey: const Key('registerForm_usernameInput_textField'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CredentialInput(
          labelText: "password",
          obscure: true,
          errorText: state.password.invalid ? 'invalid password' : null,
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password)),
          fieldKey: const Key('registerForm_passwordInput_textField'),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.passwordConfirmation != current.passwordConfirmation,
      builder: (context, state) {
        return CredentialInput(
          labelText: "confirm password",
          obscure: true,
          errorText: state.passwordConfirmation.invalid
              ? "passwords don't match"
              : null,
          onChanged: (passwordConfirmation) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordConfirmationChanged(passwordConfirmation)),
          fieldKey:
              const Key('registerForm_passwordConfirmationInput_textField'),
        );
      },
    );
  }
}

class _DateOfBirth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Data urodzenia:"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 45,
              color: Colors.grey,
            ),
            Container(
              width: 70,
              height: 45,
              color: Colors.grey,
            ),
            Container(
              width: 70,
              height: 45,
              color: Colors.grey,
            ),
          ],
        )
      ],
    );
  }
}

class _TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        "Rejestrując się wyrażasz zgodę na warunki zawarte w regulaminie.",
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : WelcomeButton(
                onPress: state.status.isValidated
                    ? () {
                        context
                            .read<RegisterBloc>()
                            .add(const RegisterSubmitted());
                      }
                    : null,
                border: Border.all(),
                padding: EdgeInsets.all(16),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0),
                splashColor: Colors.purple,
                text: Text(
                  "Zarejestruj się",
                  style: TextStyle(color: Colors.black),
                ));
      },
    );
  }
}
