import 'package:intensivevr_pub/core/services/image_manager.dart';

import 'category.dart';
import 'product.dart';

enum DiscountType { gl, pf, pp, cp }

class Discount {
  final int id;
  final String name;
  final DiscountType type;
  final DateTime dateStart;
  final String picture;
  final DateTime dateEnd;
  final double value;
  final Category category;
  final Product product;

  Discount({
    this.id,
    this.name,
    this.type,
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
        dateStart = DateTime.parse(json['discount_from']),
        dateEnd = DateTime.parse(json['discount_deadline']),
        value = json['discount_value'],
        category = json['discount_category'] != null
            ? Category.fromJson(json['discount_category'])
            : null,
        product = json['discount_product'] != null
            ? Product.fromJson(json['discount_product'])
            : null,
        picture = ImageManager.getImageUrl(json['discount_picture']);
}
