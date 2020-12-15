import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/elements/elements_list/elements_list_event.dart';
import 'package:intensivevr_pub/features/home/elements/elements_list/elements_list_state.dart';

class ElementsListBloc extends Bloc<ElementsListEvent, ElementsListState> {
  final AuthenticationBloc authBloc;
  final Function method;
  final int portion;

  ElementsListBloc({
    @required this.authBloc,
    @required this.method,
    @required this.portion,
  }) : super(InitialListState());

  @override
  Stream<ElementsListState> mapEventToState(ElementsListEvent event) async* {
    final currentState = state;
    if (event is ReachedBottomOfList && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialListState) {
          final items = await method(authBloc, 0, portion);
          yield ListLoaded(items: items, hasReachedMax: items.length < portion);
          return;
        }
        if (currentState is ListLoaded) {
          final items =
              await method(authBloc, currentState.items.length, portion);
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
    }
  }

  bool _hasReachedMax(ElementsListState state) =>
      state is ListLoaded && state.hasReachedMax;
}
