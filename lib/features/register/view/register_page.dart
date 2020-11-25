import 'package:auth_buttons/auth_buttons.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/features/register/bloc/register_bloc.dart';
import 'package:intensivevr_pub/features/register/view/register_form.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: BlocProvider(
                    create: (BuildContext context) {
                      return RegisterBloc(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      );
                    },
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (BuildContext context, state) {
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AnimatedPadding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              state.email.pure ? 30.0 : 0),
                                      duration: Duration(milliseconds: 200),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: GradientText(
                                                "Załóż konto i korzystaj z jego zalet!",
                                                style: TextStyle(
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      kPurpleGradientColor,
                                                      Colors.black
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    state.email.pure
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 70.0),
                                            child: Text(
                                              "Aby rozpocząć podaj adres Email:",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        : SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: RegisterForm(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            state.email.pure ? SocialRegister() : SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class SocialRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "lub skorzystaj z innych opcji:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: GoogleAuthButton(
                      onPressed: () {},
                      text: "Zarejestruj się z Google",
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: FacebookAuthButton(
                      onPressed: () {},
                      text: "Zarejestruj się z Facebookiem",
                    )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
