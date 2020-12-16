import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';

class ProductsListTile extends StatelessWidget {
  final Product product;

  const ProductsListTile({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Text(product.name),
    ); //TODO wykorzystać dane z product
  }
}
