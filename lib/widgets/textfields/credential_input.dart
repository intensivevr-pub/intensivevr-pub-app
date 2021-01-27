import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredentialInput extends StatelessWidget {
  final String hint;
  final String labelText;
  final String errorText;
  final void Function(String) onChanged;
  final Key fieldKey;
  final bool obscure;

  const CredentialInput(
      {Key key,
      this.hint,
      this.labelText,
      this.errorText,
      this.onChanged,
      this.obscure = false,
      this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal:16,vertical: 2),
        height: 54,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(200, 200, 200, 100),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
          key: fieldKey,
          obscureText: obscure,
          onChanged: onChanged,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.red,
            ),
            hintText: hint,
            alignLabelWithHint: true,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            labelText: labelText,
            errorText: errorText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
