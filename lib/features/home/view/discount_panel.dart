import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/discount.dart';

class DiscountPanel extends StatelessWidget {
  final Discount discount;

  const DiscountPanel({Key key, this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: Colors.red, //TODO odjebać magię żeby to działało
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bottomSheet(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
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
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheet(context) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
          return Container(
          height: MediaQuery.of(context).size.height * .8,  // TODO: make dynamic?
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
            ],
          )
      );
      }
    );
  }
}