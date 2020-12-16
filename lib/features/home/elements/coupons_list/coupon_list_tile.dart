import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:palette_generator/palette_generator.dart';

class CouponListTile extends StatefulWidget {
  final Coupon coupon;

  const CouponListTile({Key key, this.coupon}) : super(key: key);

  @override
  _CouponListTileState createState() => _CouponListTileState();
}

class _CouponListTileState extends State<CouponListTile> {
  bool loaded = false;
  Color backgroundColor;
  Color textColor;
  PaletteGenerator paletteGenerator;

  void getColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.coupon.prize.thumbnail),
    );
    if (paletteGenerator.lightMutedColor != null) {
      backgroundColor = paletteGenerator.lightMutedColor.color;
      textColor = paletteGenerator.lightMutedColor.bodyTextColor;
    } else {
      backgroundColor = Colors.grey[200];
      textColor = Colors.black;
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    getColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: loaded ? backgroundColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Text(
                  widget.coupon.prize.name,
                  style: TextStyle(color: loaded ? textColor : Colors.black),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: NetworkImage(widget.coupon.prize.thumbnail),
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
