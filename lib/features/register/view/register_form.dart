import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/widgets/buttons/welcome_button.dart';
import 'package:intensivevr_pub/widgets/textfields/credential_input.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CredentialInput(
      labelText: "E-mail",
    );
  }
}

class _LoginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CredentialInput(
      labelText: "Login",
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CredentialInput(
      labelText: "Hasło",
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CredentialInput(
      labelText: "Potwierdź hasło",
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
    return WelcomeButton(
      onPress: () {},
      border: Border.all(),
      padding: EdgeInsets.all(16),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Color.fromRGBO(255, 255, 255, 0),
      splashColor: Colors.purple,
      text: Text(
        "Zarejestruj się",
        style: TextStyle(color: Colors.black),
      )
    );
  }
}
