import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intensivevr_pub/features/home/home.dart';
import 'package:intensivevr_pub/features/login/login.dart';
import 'package:intensivevr_pub/features/register/register.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GradientText(
                  'welcome_message'.tr(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: const LinearGradient(
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
                          padding: const EdgeInsets.all(16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromRGBO(255, 255, 255, 0),
                          splashColor: Colors.purple,
                          text: Text(
                            'log_in'.tr(),
                            style: const TextStyle(color: Colors.black),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: WelcomeButton(
                          onPress: () {
                            Navigator.push(context, RegisterPage.route());
                          },
                          padding: const EdgeInsets.all(16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue,
                          splashColor: Colors.purple,
                          text: Text(
                            'register'.tr(),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: WelcomeButton(
                          onPress: () {
                            Navigator.push(context, HomePage.route(demo: true));
                          },
                          padding: const EdgeInsets.all(16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue,
                          splashColor: Colors.purple,
                          text: Text(
                            'demo_mode'.tr(),
                            style: const TextStyle(color: Colors.white),
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
