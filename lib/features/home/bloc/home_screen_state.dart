part of 'home_screen_bloc.dart';

@immutable
class HomeScreenState {
  final bool online;
  final bool demo;
  final bool refreshing;

  const HomeScreenState({this.online, this.demo, this.refreshing});

  HomeScreenState copyWith({bool online, bool demo, bool refreshing}) {
    return HomeScreenState(
      online: online ?? this.online,
      demo: demo ?? this.demo,
      refreshing: refreshing ?? this.refreshing,
    );
  }
}
