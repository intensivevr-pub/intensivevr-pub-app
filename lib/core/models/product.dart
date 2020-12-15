import 'package:intensivevr_pub/core/services/image_manager.dart';

import '../../const.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String picture;
  final double price;
  final String category;

  Product({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.price,
    this.category,
  });

  Product.fromJson(json)
      : id = json['id'],
        name = json['product_name'],
        description = json['description'],
        picture = ImageManager.getImageUrl(json['picture']),
        price = json['regular_price'],
        category = json['category'];
}