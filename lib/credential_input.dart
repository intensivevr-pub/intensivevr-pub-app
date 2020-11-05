import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredentialInput extends StatelessWidget{
  final String hint;

  const CredentialInput({Key key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(200, 200, 200, 100),
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
      ),
    );
  }

}