import 'package:equatable/equatable.dart';

abstract class GenericListState extends Equatable {
  @override
  List<Object> get props => [];

  const GenericListState();
}

class InitialListState extends GenericListState {}

class LoadingItems extends GenericListState {}

class ListLoaded extends GenericListState {
  final List<dynamic> items;
  final bool hasReachedMax;

  const ListLoaded({this.hasReachedMax, this.items});

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

class ListError extends GenericListState {}
