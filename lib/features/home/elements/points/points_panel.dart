import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointsPanel extends StatelessWidget {
  final int points;
  final bool demo;

  const PointsPanel({Key key, this.points, this.demo = false})
      : super(key: key);

  String determineForm(BuildContext context) {
    if (points < 10) {
      return 'point'.plural(points,
          format: NumberFormat.compact(locale: context.locale.toString()));
    } else if (points % 10 > 1 && points % 10 < 5) {
      return 'point'.plural(points,
          format: NumberFormat.compact(locale: context.locale.toString()));
    }
    return 'point'.plural(points,
        format: NumberFormat.compact(locale: context.locale.toString()));
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
                Text(
                  'you_have_exactly'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  determineForm(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'demo_points'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
    );
  }
}
