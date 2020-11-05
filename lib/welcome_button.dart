import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WelcomeButton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final Color color;
  final Gradient gradient;
  final Text text;
  final VoidCallback onPress;
  final Color splashColor;
  final Border border;
  final TextStyle textStyle;
  final EdgeInsets padding;

  const WelcomeButton({Key key, this.height, this.width, this.borderRadius, this.color, this.gradient, this.text, this.onPress, this.splashColor, this.border, this.textStyle, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: borderRadius,
          border: border,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPress,
            borderRadius: borderRadius,
            splashColor: splashColor,
            child: Center(
              child: Padding(
                padding: padding,
                child: text,
              ),
            ),
          ),
        ),
      ),
    );
  }

}