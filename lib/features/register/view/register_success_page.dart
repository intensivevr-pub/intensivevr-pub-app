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
            Container(
              child: Text("Rejestracja powiodła się!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text("Kliknij w link aktywacyjny w mailu!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: WelcomeButton(
                  onPress: () =>
                      Navigator.pushReplacement(context, LoginPage.route()),
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  splashColor: Colors.purple,
                  text: Text(
                    "Przejdź do logowania",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),

        ],
      ),
    ));
  }
}
