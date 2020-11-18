import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String authToken;

  const User(this.authToken);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  static const empty = User('-');
}
