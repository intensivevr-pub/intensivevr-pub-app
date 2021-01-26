import 'package:flutter/material.dart';
import 'package:intensivevr_pub/features/login/login.dart';

class RegisterSuccessPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Rejestracja powiodła się!"),
          ),
          Container(
            child: Text("Szukaj potwierdzenia na mailu!"),
          ),
          InkWell(
              onTap: () =>
                  Navigator.pushReplacement(context, LoginPage.route()),
              child: Container(
                child: Text("Przejdź do logowania"),
              ))
        ],
      ),
    ));
  }
}
