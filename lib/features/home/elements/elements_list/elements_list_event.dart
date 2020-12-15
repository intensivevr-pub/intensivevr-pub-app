import 'package:equatable/equatable.dart';

abstract class ElementsListEvent extends Equatable {
  const ElementsListEvent();
}

class LoadedItems extends ElementsListEvent {
  @override
  List<Object> get props => [];
}

class ReachedBottomOfList extends ElementsListEvent {
  @override
  List<Object> get props => [];
}

class LoadingMoreItems extends ElementsListEvent {
  @override
  List<Object> get props => [];
}
