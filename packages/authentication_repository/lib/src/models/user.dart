import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String authToken;

  const User(this.authToken);

  @override
  List<Object> get props => [authToken];
  static const empty = User('-');
}
