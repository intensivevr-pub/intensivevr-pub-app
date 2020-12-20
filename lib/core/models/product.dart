import 'package:intensivevr_pub/core/services/image_manager.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final String picture;
  final double price;
  final String category;

  Product({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.picture,
    this.price,
    this.category,
  });

  Product.fromJson(json)
      : id = json['id'],
        name = json['product_name'],
        description = json['description'],
        thumbnail = ImageManager.getCompressedImageUrl(json['picture']),
        picture = ImageManager.getImageUrl(json['picture']),
        price = json['regular_price'],
        category = json['category'];
}
