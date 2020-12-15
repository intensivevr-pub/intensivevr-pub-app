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

  Coupon.fromJson(var json)
      : id = json['id'],
        prize = Prize.fromJson(json['prize']),
        deadline = json['coupon_deadline'] != null
            ? DateTime.parse(json['coupon_deadline'])
            : null,
        code = json['coupon_code'];
}
