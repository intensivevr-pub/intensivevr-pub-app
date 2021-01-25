import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  bool online;
  bool demo;

  HomeScreenBloc(this.online, this.demo)
      : super(HomeScreenState(online, demo, false));

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is RefreshRequested) {
      yield state.copyWith(refreshing: true);
      if (event.online){
        yield state.copyWith(online: true, refreshing: false);
      }else{
        yield state.copyWith(online: false, refreshing: false);
      }
    }
  }
}
