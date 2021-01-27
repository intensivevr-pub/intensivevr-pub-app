import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointsPanel extends StatelessWidget {
  final int points;
  final bool demo;

  const PointsPanel({Key key, this.points, this.demo = false})
      : super(key: key);

  String determineForm() {
    if (points == 1) {
      return "1 punkt";
    }
    if (points % 10 > 1 && points % 10 < 5) {
      return "$points punkty";
    }
    return "$points punktów";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.blue]),
      ),
      child: !demo
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Masz dokładnie:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  determineForm(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Tutaj będziesz widzieć liczbę punktów",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
    );
  }
}
