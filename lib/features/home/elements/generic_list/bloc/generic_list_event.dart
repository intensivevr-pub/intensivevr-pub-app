import 'package:equatable/equatable.dart';

abstract class GenericListEvent extends Equatable {
  const GenericListEvent();
}

class LoadedItems extends GenericListEvent {
  @override
  List<Object> get props => [];
}

class ReachedBottomOfList extends GenericListEvent {
  @override
  List<Object> get props => [];
}

class LoadingMoreItems extends GenericListEvent {
  @override
  List<Object> get props => [];
}
