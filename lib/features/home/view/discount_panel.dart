import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountPanel extends StatelessWidget {
  final Color color;
  final String product;
  final String discount;

  const DiscountPanel({Key key, this.color, this.product, this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.product,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            this.discount,
            style: TextStyle(
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

}