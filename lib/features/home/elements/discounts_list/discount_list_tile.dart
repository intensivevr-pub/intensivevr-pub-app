import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/discount.dart';

class DiscountListTile extends StatelessWidget {
  final Discount discount;
  static Color color = Colors.green[600];

  const DiscountListTile({Key key, this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: color, //TODO odjebać magię żeby to działało
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
                    Text(
                      discount.name ?? "maselko",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image(
                        image: NetworkImage(discount.thumbnail),
                        height: 110,
                      ),
                    )]
              )
          ),
        ),
      ),
    );
  }

    //TODO: more details
  void bottomSheet(context) {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      discount.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image(
                      image: NetworkImage(discount.picture),
                      height: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      formatDescription(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Text(
                    "Promocja aktywna w dniach:\n" + formatDate(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                ],
              )
          );
        }
    );
  }

  String formatDescription() {
    switch(discount.type){
      case DiscountType.gl:
        return "global, ale bedzie";
      case DiscountType.pf:
        return discount.product.description;
      case DiscountType.pp:
        return discount.product.description;
      case DiscountType.cp:
        return "kategoria, ale bedzie";
      default:
        return "Oj, tego nie wiem";
    }
  }
  String formatDate() {
    return discount.dateStart.day.toString() + '.'
        + discount.dateStart.month.toString() + ' - '
        + discount.dateEnd.day.toString() + '.'
        + discount.dateEnd.month.toString();

  }
}