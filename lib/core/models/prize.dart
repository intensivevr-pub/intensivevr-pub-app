import 'product.dart';

enum PrizeType { free, promo }

class Prize {
  final int id;
  final String name;
  final PrizeType type;
  final double percentage;
  final bool isLifetime;
  final int cost;
  final DateTime deadline;
  final Product product;

  Prize({
    this.id,
    this.name,
    this.type,
    this.percentage,
    this.isLifetime,
    this.cost,
    this.deadline,
    this.product,
  });
}
