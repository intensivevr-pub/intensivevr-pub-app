import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/bloc/generic_list_event.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/bloc/generic_list_state.dart';

class GenericListBloc extends Bloc<GenericListEvent, GenericListState> {
  final Function method;
  final int portion;

  GenericListBloc({
    @required this.method,
    @required this.portion,
  }) : super(InitialListState());

  @override
  Stream<GenericListState> mapEventToState(GenericListEvent event) async* {
    final currentState = state;
    if (event is ReachedBottomOfList && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialListState) {
          final items = await method(0, portion);
          yield ListLoaded(items: items, hasReachedMax: items.length < portion);
          return;
        }
        if (currentState is ListLoaded) {
          final items =
              await method(currentState.items.length, portion);
          yield items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ListLoaded(
                  items: currentState.items + items,
                  hasReachedMax: false,
                );
        }
      } catch (e, s) {
        print("$e,$s");
        yield ListError();
      }
    } else if (event is ReloadItems) {
      try {
        final items = await method( 0, portion);
        yield ListLoaded(items: items, hasReachedMax: items.length < portion);
      }catch(e){
        yield ListError();
      }
    }
  }

  bool _hasReachedMax(GenericListState state) =>
      state is ListLoaded && state.hasReachedMax;
}
