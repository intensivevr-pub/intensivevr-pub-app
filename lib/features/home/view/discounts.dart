import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'discount_panel.dart';

class Discounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Aktualne promocje:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DiscountPanel(color: Colors.teal, product: "Perła", discount: "-20%",),
                DiscountPanel(color: Colors.teal, product: "Perła", discount: "-20%",),
                DiscountPanel(color: Colors.teal, product: "Perła", discount: "-20%",),
                DiscountPanel(color: Colors.teal, product: "Perła", discount: "-20%",),
                DiscountPanel(color: Colors.teal, product: "Perła", discount: "-20%",),
              ],
            ),
          ),
        ],
      ),
    );
  }

}