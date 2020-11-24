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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmailInput(),
              AppearingInput(
                child: _LoginInput(),
                visible: !state.email.pure,
              ),
              AppearingInput(
                child: _PasswordInput(),
                visible: !state.username.pure,
              ),
              AppearingInput(
                  child: _ConfirmPasswordInput(),
                  visible: !state.password.pure),
              AppearingInput(
                  child: _DateOfBirth(),
                  visible: !state.passwordConfirmation.pure),
              AppearingInput(
                  child: _TermsOfUse(),
                  visible: !state.passwordConfirmation.pure),
              AppearingInput(
                  child: _RegisterButton(),
                  visible: !state.passwordConfirmation.pure),
            ],
          );
        },
      ),
    );
  }
}

class AppearingInput extends StatelessWidget {
  final bool visible;
  final Widget child;

  AppearingInput({this.visible, this.child});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainState: true,
      maintainAnimation: true,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: child,
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CredentialInput(
            labelText: "Email",
            errorText:
                state.email.invalid ? state.email.getErrorMessage() : null,
            onChanged: (email) =>
                context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
            fieldKey: const Key('registerForm_emailInput_textField'),
          ),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CredentialInput(
            labelText: "Nick",
            errorText: state.username.invalid
                ? 'Nick nie może być pusty'
                : null,
            onChanged: (username) =>
                context
                    .read<RegisterBloc>()
                    .add(RegisterUsernameChanged(username)),
            fieldKey: const Key('registerForm_usernameInput_textField'),
          ),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CredentialInput(
            labelText: "Hasło",
            obscure: true,
            errorText:
            state.password.invalid ? state.password.getErrorMessage() : null,
            onChanged: (password) =>
                context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordChanged(password)),
            fieldKey: const Key('registerForm_passwordInput_textField'),
          ),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CredentialInput(
            labelText: "Potwierdź hasło",
            obscure: true,
            errorText: state.passwordConfirmation.invalid
                ? "Hasła nie są takie same"
                : null,
            onChanged: (passwordConfirmation) =>
                context
                    .read<RegisterBloc>()
                    .add(
                    RegisterPasswordConfirmationChanged(passwordConfirmation)),
            fieldKey:
            const Key('registerForm_passwordConfirmationInput_textField'),
          ),
        );
      },
    );
  }
}

class _DateOfBirth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Data urodzenia:"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Container(
            height: 60,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {  },
              mode: CupertinoDatePickerMode.date,
              use24hFormat: false,
            ),
          ),
        )
      ],

    );
  }
}

class _TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
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
