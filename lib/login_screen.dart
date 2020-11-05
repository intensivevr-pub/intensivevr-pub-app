import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intensivevr_pub/credential_input.dart';

import 'welcome_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GradientText(
                  "Zaloguj się i dołącz do rozrywki",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple, Colors.black]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CredentialInput(hint: "Nazwa użytkownika",),
                    CredentialInput(hint: "Hasło"),
                    WelcomeButton(
                        onPress: () {},
                        border: Border.all(),
                        padding: EdgeInsets.all(16),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(255, 255, 255, 0),
                        splashColor: Colors.purple,
                        text: Text(
                          "Zaloguj się",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, left: 16, right: 16 ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WelcomeButton(
                        onPress: () {},
                        padding: EdgeInsets.all(16),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red,
                        splashColor: Colors.purple,
                        text: Text(
                          "Zaloguj się z google",
                          style: TextStyle(color: Colors.white),
                        )),
                    WelcomeButton(
                        onPress: () {},
                        padding: EdgeInsets.all(16),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue,
                        splashColor: Colors.purple,
                        text: Text(
                          "Zaloguj się z Facebook",
                          style: TextStyle(color: Colors.white),
                        ))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
