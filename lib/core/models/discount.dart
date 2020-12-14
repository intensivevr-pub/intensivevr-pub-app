import 'category.dart';
import 'product.dart';

enum DiscountType { gl, pf, pp, cp }

class Discount {
  final int id;
  final String discountName;
  final DiscountType type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final double value;
  final Category category;
  final Product product;

  Discount({
    this.id,
    this.discountName,
    this.type,
    this.dateStart,
    this.dateEnd,
    this.value,
    this.category,
    this.product,
  });
}
