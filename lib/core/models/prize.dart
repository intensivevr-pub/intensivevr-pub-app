import 'package:intensivevr_pub/core/services/image_manager.dart';

import 'product.dart';

enum PrizeType { free, promo }

class Prize {
  final int id;
  final String name;
  final PrizeType type;
  final double percentage;
  final bool isLimited;
  final int cost;
  final DateTime deadline;
  final Product product;
  final String picture;

  Prize({
    this.id,
    this.name,
    this.picture,
    this.type,
    this.percentage,
    this.isLimited,
    this.cost,
    this.deadline,
    this.product,
  });

  Prize.fromJson(var json)
      : id = json['id'],
        name = json['prize_name'],
        type = PrizeType.values.firstWhere(
            (e) => e.toString() == 'PrizeType.' + json['prize_type']),
        percentage = json['prize_percentage'] != null
            ? json['prize_percentage'].toDouble()
            : null,
        isLimited = json['isLimited'],
        cost = json['prize_cost'],
        deadline = json['prize_deadline'] != null
            ? DateTime.parse(json['prize_deadline'])
            : null,
        product = json['prize_product'] != null
            ? Product.fromJson(json['prize_product'])
            : null,
        picture = ImageManager.getImageUrl(json['prize_picture']);
}
