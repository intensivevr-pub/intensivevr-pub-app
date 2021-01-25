part of 'home_screen_bloc.dart';

@immutable
class HomeScreenState {
  final bool online;
  final bool demo;
  final bool refreshing;

  HomeScreenState(this.online, this.demo, this.refreshing);

  HomeScreenState copyWith({online, demo, refreshing}) {
    return HomeScreenState(
      online ?? this.online,
      demo ?? this.demo,
      refreshing ?? this.refreshing,
    );
  }
}
