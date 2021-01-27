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

  Product.fromJson(Map<String,dynamic> json)
      : id = int.tryParse(json['id'].toString()),
        name = json['product_name'].toString(),
        description = json['description'].toString(),
        thumbnail =
            ImageManager.getCompressedImageUrl(json['picture'].toString()),
        picture = ImageManager.getImageUrl(json['picture'].toString()),
        price = double.tryParse(json['regular_price'].toString()),
        category = json['category'].toString();
}
