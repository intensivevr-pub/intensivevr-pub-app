import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/discount.dart';
import 'package:palette_generator/palette_generator.dart';

class DiscountListTile extends StatefulWidget {
  final Discount discount;
  static Color color = Colors.green[600];

  const DiscountListTile({Key key, this.discount}) : super(key: key);

  @override
  _DiscountListTileState createState() => _DiscountListTileState();
}

class _DiscountListTileState extends State<DiscountListTile> {
  bool loaded = false;
  Color backgroundColor;
  Color textColor;
  PaletteGenerator paletteGenerator;
  @override
  void initState() {
    getColors();
    super.initState();
  }
  void getColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.discount.thumbnail),
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: loaded ? backgroundColor :DiscountListTile.color,
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
                          widget.discount.name,
                          style: TextStyle(
                            color:loaded ? textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.discount.value.toString(),
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
                        image: NetworkImage(widget.discount.thumbnail),
                        height: 110,
                      ),
                    )]
              )
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
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: DiscountListTile.color,
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
                        widget.discount.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      Text(
                        widget.discount.value.toString(),
                        style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  Image(
                    image: NetworkImage(widget.discount.picture),
                    height: 250,
                  ),
                ],
              )
          );
        }
    );
  }
}