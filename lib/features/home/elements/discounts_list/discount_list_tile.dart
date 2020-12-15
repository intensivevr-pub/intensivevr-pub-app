import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/discount.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/view/generic_tile.dart';

class DiscountListTile extends GenericListTile {
  final Discount discount;
  static Color color = Colors.green[600];

  const DiscountListTile({Key key, this.discount}) : super(key: key);

  @override
  Widget setMainContent() {
    return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                discount.name ?? "maselko",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                discount.value.toString(),
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image(
              image: NetworkImage(discount.picture),
              height: 110,
            ),
          )]
    );
  }

  @override
  List<Widget> setSheetContent() {
    return [
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          discount.name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        Text(
          discount.value.toString(),
          style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14
          ),
        ),
      ],
    ),
    Image(
    image: NetworkImage(discount.product.picture),
    height: 250,
    ),
    ];
  }
}