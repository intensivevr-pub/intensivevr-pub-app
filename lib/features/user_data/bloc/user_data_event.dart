import 'package:meta/meta.dart';

@immutable
abstract class UserDataEvent {}


class GetInitialUserData extends UserDataEvent {}

class RefreshPointsAndRewards extends  UserDataEvent{}

