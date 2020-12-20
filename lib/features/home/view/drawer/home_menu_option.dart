import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMenuOption extends StatelessWidget {
  final String title;
  final Function onPress;

  const HomeMenuOption({Key key, this.title, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      onTap: onPress,
    );
  }

}