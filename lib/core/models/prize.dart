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
  final String thumbnail;
  final String picture;

  Prize({
    this.id,
    this.name,
    this.thumbnail,
    this.picture,
    this.type,
    this.percentage,
    this.isLimited,
    this.cost,
    this.deadline,
    this.product,
  });

  Prize.fromJson(Map<String,dynamic> json)
      : id = int.tryParse(json['id'].toString()),
        name = json['prize_name'].toString(),
        type = PrizeType.values.firstWhere(
            (e) => e.toString() == 'PrizeType.${json['prize_type']}'),
        percentage = json['prize_percentage'] != null
            ? double.tryParse(json['prize_percentage'].toString())
            : null,
        isLimited =
            bool.fromEnvironment(json['isLimited'].toString().toLowerCase()),
        cost = int.tryParse(json['prize_cost'].toString()),
        deadline = json['prize_deadline'] != null
            ? DateTime.parse(json['prize_deadline'].toString())
            : null,
        product = json['prize_product'] != null
            ? Product.fromJson(json['prize_product'] as Map<String,dynamic>)
            : null,
        thumbnail = ImageManager.getCompressedImageUrl(
            json['prize_picture'].toString()),
        picture = ImageManager.getImageUrl(json['prize_picture'].toString());
}
