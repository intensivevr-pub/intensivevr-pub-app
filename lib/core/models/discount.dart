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

  Discount.fromJson(var json)
      : id = json['id'],
        name = json['discount_name'],
        type = DiscountType.values.firstWhere(
            (e) => e.toString() == 'DiscountType.' + json['discount_type']),
        dateStart = json['discount_from'] != null ? DateTime.parse(json['discount_from']) : null,
        dateEnd = json['discount_deadline'] != null ? DateTime.parse(json['discount_deadline']) : null,
        value = json['discount_value'],
        category = json['discount_category'] != null
            ? Category.fromJson(json['discount_category'])
            : null,
        product = json['discount_product'] != null
            ? Product.fromJson(json['discount_product'])
            : null,
        thumbnail = ImageManager.getCompressedImageUrl(json['discount_picture']),
        picture = ImageManager.getImageUrl(json['discount_picture']);
}
