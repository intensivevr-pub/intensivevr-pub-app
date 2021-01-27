import 'package:flutter/material.dart';
import 'package:intensivevr_pub/features/login/login.dart';
import 'package:intensivevr_pub/widgets/buttons/welcome_button.dart';

class RegisterSuccessPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Rejestracja powiodła się!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Kliknij w link aktywacyjny w mailu!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: WelcomeButton(
                  onPress: () =>
                      Navigator.pushReplacement(context, LoginPage.route()),
                  padding: const EdgeInsets.all(16),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  splashColor: Colors.purple,
                  text: const Text(
                    "Przejdź do logowania",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),

        ],
      ),
    ));
  }
}
