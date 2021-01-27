part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class RefreshRequested extends HomeScreenEvent {
  final bool online;

  RefreshRequested({this.online});

}
