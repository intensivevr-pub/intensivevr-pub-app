import 'package:meta/meta.dart';

@immutable
abstract class UserDataEvent {}

class TryUpdateUserPoints extends UserDataEvent {}

class GetInitialUserData extends UserDataEvent {}
