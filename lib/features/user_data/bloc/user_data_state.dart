import 'package:equatable/equatable.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class UserDataState extends Equatable {
  final String username;
  final int points;
  final String hash;
  final List<Coupon> activeCoupons;

  UserDataState({
    @required this.username,
    @required this.points,
    @required this.hash,
    @required this.activeCoupons,
  });

  factory UserDataState.initial() {
    return UserDataState(
        username: "User", points: -1, hash: "hash", activeCoupons: []);
  }

  UserDataState copyWith({
    final String username,
    final int points,
    final String hash,
    final List<Coupon> activeRewards,
  }) {
    return UserDataState(
      username: username ?? this.username,
      points: points ?? this.points,
      hash: hash ?? this.hash,
      activeCoupons: activeRewards ?? this.activeCoupons,
    );
  }

  @override
  List<Object> get props => [username, points, hash,activeCoupons];
}
