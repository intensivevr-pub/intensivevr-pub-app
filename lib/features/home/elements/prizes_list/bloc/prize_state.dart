part of 'prize_bloc.dart';

@immutable
abstract class PrizeState {}

class InitialPrizeState extends PrizeState {}

class LoadingPrizeRealization extends PrizeState{}

class PrizeCollected extends PrizeState{}

class PrizeCollectionError extends PrizeState{}