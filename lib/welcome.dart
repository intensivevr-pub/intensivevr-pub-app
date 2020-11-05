

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              "Witamy w IntensiveVRPub!",
              style: TextStyle(
                color:Colors.lime,
                fontSize: 32,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => {},
                    color: Colors.red,
                    splashColor: Colors.green,
                    child: Text("Zaloguj się"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => {},
                    color: Colors.blue,
                    child: Text("Utwórz konto"),

                  ),
                )
              ]
            )],
          ),
        ),
      ),
    );
  }
}

