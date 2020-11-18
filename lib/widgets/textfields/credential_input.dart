import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredentialInput extends StatelessWidget {
  final String hint;
  final String labelText;
  final String errorText;
  final Function onChanged;
  final Key fieldKey;

  const CredentialInput(
      {Key key,
      this.hint,
      this.labelText,
      this.errorText,
      this.onChanged,
      this.fieldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:16,vertical: 5),
        height: 45,
        child: TextFormField(
          key: fieldKey,
          maxLines: 1,
          onChanged: onChanged,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            labelText: labelText,
            errorText: errorText,
            border: InputBorder.none,
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(200, 200, 200, 100),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
