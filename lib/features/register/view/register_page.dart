import 'package:auth_buttons/auth_buttons.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/features/register/bloc/register_bloc.dart';
import 'package:intensivevr_pub/features/register/view/register_form.dart';
import 'package:intensivevr_pub/features/register/view/register_success_page.dart';

class RegisterPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (BuildContext context) {
              return RegisterBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: RegisterPage()));
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc registerBloc;

  @override
  void initState() {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      cubit: registerBloc,
      listener: (BuildContext context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.pushReplacement(context, RegisterSuccessPage.route());
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
            resizeToAvoidBottomPadding: true,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AnimatedPadding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: state.email.pure ? 30.0 : 0),
                                    duration: const Duration(milliseconds: 200),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: GradientText(
                                              "Załóż konto i korzystaj z jego zalet!",
                                              style: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              gradient: const LinearGradient(
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
                                  if (state.email.pure)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 70.0),
                                      child: Text(
                                        "Aby rozpocząć podaj adres Email:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: RegisterForm(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (state.email.pure)
                            SocialRegister()
                          else
                            const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class SocialRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
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
