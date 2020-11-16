import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intensivevr_pub/features/login/login.dart';
import 'package:intensivevr_pub/widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Witamy w IntensiveVRPub!",
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: WelcomeButton(
                          onPress: () {
                            Navigator.push(context, LoginPage.route());
                          },
                          border: Border.all(),
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromRGBO(255, 255, 255, 0),
                          splashColor: Colors.purple,
                          text: Text(
                            "Zaloguj się",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: WelcomeButton(
                          onPress: () {},
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue,
                          splashColor: Colors.purple,
                          text: Text(
                            "Utwórz konto",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
