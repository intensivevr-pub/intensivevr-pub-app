import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_text/gradient_text.dart';
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
          child: BlocProvider(
            create: (BuildContext context) {
              return RegisterBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: GradientText(
                      "Załóż konto i korzystaj z jego zalet!",
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
                    child: RegisterForm(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
