import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountPanel extends StatelessWidget {
  final Color color;
  final String product;
  final String discount;
  final ImageProvider img;


  const DiscountPanel({Key key, this.color, this.product, this.discount, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            bottomSheet(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
              children: [Column(
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: img,
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
          height: MediaQuery.of(context).size.height * .85,  // TODO: make dynamic?
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    this.product,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    this.discount,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Image(
                image: img,
                height: 250,
              ),
              Icon(Icons.qr_code, size: 200,)
            ],
          )
      );
      }
    );
  }
}