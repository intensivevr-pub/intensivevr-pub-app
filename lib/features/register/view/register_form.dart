import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
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
          if (state.error != null) {
            if (state.error.runtimeType == EmailAlreadyExistsError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('form_errors.duplicate_email'.tr())));
            } else if (state.error.runtimeType == UsernameTakenError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("form_error.duplicate_username".tr())));
            } else if (state.error.runtimeType == EmailIncorrectError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text('unknown_email_error'.tr())));
            }
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('unknown_error'.tr())));
          }
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EmailInput(),
              AppearingInput(
                visible: !state.email.pure,
                child: _LoginInput(),
              ),
              AppearingInput(
                visible: !state.username.pure,
                child: _PasswordInput(),
              ),
              AppearingInput(
                visible: !state.password.pure,
                child: _ConfirmPasswordInput(),
              ),
              AppearingInput(
                visible: !state.passwordConfirmation.pure,
                child: _DateOfBirth(),
              ),
              AppearingInput(
                visible: !state.passwordConfirmation.pure,
                child: _TermsOfUse(),
              ),
              AppearingInput(
                visible: !state.passwordConfirmation.pure,
                child: _RegisterButton(),
              ),
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

  const AppearingInput({this.visible, this.child});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainState: true,
      maintainAnimation: true,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
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
            onChanged: (String email) =>
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
            labelText: 'username'.tr(),
            errorText: state.username.invalid
                ? 'form_errors.username_can_not_be_empty'
                : null,
            onChanged: (String username) => context
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
            labelText: 'password'.tr(),
            obscure: true,
            errorText: state.password.invalid
                ? state.password.getErrorMessage()
                : null,
            onChanged: (String password) => context
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
            labelText: 'confirm_password'.tr(),
            obscure: true,
            errorText: state.passwordConfirmation.invalid
                ? 'form_errors.passwords_do_not_match'.tr()
                : null,
            onChanged: (String passwordConfirmation) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordConfirmationChanged(passwordConfirmation)),
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
          child: Text('birth_date'.tr()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 60,
            child: CupertinoDatePicker(
              onDateTimeChanged: (DateTime value) {},
              mode: CupertinoDatePickerMode.date,
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
        'terms_of_use'.tr(),
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
                padding: const EdgeInsets.all(16),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: const Color.fromRGBO(255, 255, 255, 0),
                splashColor: Colors.purple,
                text: Text(
                  'register'.tr(),
                  style: const TextStyle(color: Colors.black),
                ));
      },
    );
  }
}
