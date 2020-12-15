import 'package:equatable/equatable.dart';

abstract class ElementsListState extends Equatable {
  @override
  List<Object> get props => [];

  const ElementsListState();
}

class InitialListState extends ElementsListState {}

class LoadingItems extends ElementsListState {}

class ListLoaded extends ElementsListState {
  final List<dynamic> items;
  final bool hasReachedMax;

  ListLoaded({this.hasReachedMax, this.items});

  ListLoaded copyWith({
    List<dynamic> items,
    bool hasReachedMax,
  }) {
    return ListLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ListError extends ElementsListState {}
