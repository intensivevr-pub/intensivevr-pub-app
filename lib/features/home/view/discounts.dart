import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'discount_panel.dart';

class Discounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
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
                child: Row(
                  children: [
                    DiscountPanel(color: Colors.green[600], product: "Perła Export", discount: "-23%",),
                    DiscountPanel(color: Colors.lightGreen[600], product: "Perła Chmielowa", discount: "-40%",),
                    DiscountPanel(color: Colors.yellow[600], product: "Perła Miodowa", discount: "+20%",),
                    DiscountPanel(color: Colors.grey[800], product: "Perła Mocna", discount: "-69%",),
                    DiscountPanel(color: Colors.teal, product: "Perła Radler", discount: "-100%, i tak nikt nie kupi",),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}