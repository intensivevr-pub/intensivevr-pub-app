import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';

class CouponListTile extends StatelessWidget {
  final Coupon coupon;

  const CouponListTile({Key key, this.coupon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {

          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Text(coupon.prize.name),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: NetworkImage(coupon.prize.thumbnail),
                    height: 100,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
