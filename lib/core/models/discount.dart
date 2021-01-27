import 'package:intensivevr_pub/core/services/image_manager.dart';

import 'category.dart';
import 'product.dart';

enum DiscountType { gl, pf, pp, cp }

class Discount {
  final int id;
  final String name;
  final DiscountType type;
  final DateTime dateStart;
  final String thumbnail;
  final String picture;
  final DateTime dateEnd;
  final double value;
  final Category category;
  final Product product;

  Discount({
    this.id,
    this.name,
    this.type,
    this.thumbnail,
    this.picture,
    this.dateStart,
    this.dateEnd,
    this.value,
    this.category,
    this.product,
  });

  Discount.fromJson(Map<String,dynamic> json)
      : id = int.tryParse(json['id'].toString()),
        name = json['discount_name'].toString(),
        type = DiscountType.values.firstWhere(
            (e) => e.toString() == 'DiscountType.${json['discount_type']}'),
        dateStart = json['discount_from'] != null ? DateTime.parse(json['discount_from'].toString()) : null,
        dateEnd = json['discount_deadline'] != null ? DateTime.parse(json['discount_deadline'].toString()) : null,
        value = double.tryParse(json['discount_value'].toString()),
        category = json['discount_category'] != null
            ? Category.fromJson(json['discount_category'] as Map<String,dynamic>)
            : null,
        product = json['discount_product'] != null
            ? Product.fromJson(json['discount_product'] as Map<String,dynamic>)
            : null,
        thumbnail = ImageManager.getCompressedImageUrl(json['discount_picture'].toString()),
        picture = ImageManager.getImageUrl(json['discount_picture'].toString());
}
