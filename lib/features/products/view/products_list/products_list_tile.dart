import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductsListTile extends StatefulWidget {
  final Product product;

  const ProductsListTile({Key key, this.product}) : super(key: key);

  @override
  _ProductsListTileState createState() => _ProductsListTileState();
}

class _ProductsListTileState extends State<ProductsListTile> {
  bool loaded = false;
  Color backgroundColor;
  Color textColor;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    getColors();
    super.initState();
  }

  Future<bool> getColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.product.thumbnail),
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
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
            color: loaded ? backgroundColor : Colors.white,
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  color: loaded ? textColor : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.product.picture))),
                ),
              ),
            ),
            Text(widget.product.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: loaded ? textColor : Colors.black,
                )),
          ],
        ),
      ),
    ); //TODO wykorzystać dane z product
  }
}
