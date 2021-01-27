import 'package:intensivevr_pub/core/models/models.dart';

enum CouponType { free, promo }

class Coupon {
  final int id;
  final Prize prize;
  final DateTime deadline;
  final String code;

  Coupon({
    this.id,
    this.prize,
    this.deadline,
    this.code,
  });

  Coupon.fromJson(Map<String,dynamic> json)
      : id = int.tryParse(json['id'].toString()),
        prize = Prize.fromJson(json['prize'] as Map<String,dynamic>),
        deadline = json['coupon_deadline'] != null
            ? DateTime.parse(json['coupon_deadline'].toString())
            : null,
        code = json['coupon_code'].toString();
}
