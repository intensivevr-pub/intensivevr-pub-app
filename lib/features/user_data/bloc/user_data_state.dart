import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UserDataState extends Equatable {
  final String username;
  final int points;
  final String hash;

  UserDataState({
    @required this.username,
    @required this.points,
    @required this.hash,
  });

  factory UserDataState.initial() {
    return UserDataState(username: "User", points: -1, hash: "hash");
  }

  UserDataState copyWith({
    final String username,
    final int points,
    final String hash,
  }) {
    return UserDataState(
      username: username ?? this.username,
      points: points ?? this.points,
      hash: hash ?? this.hash,
    );
  }

  @override
  List<Object> get props => [username, points, hash];
}
