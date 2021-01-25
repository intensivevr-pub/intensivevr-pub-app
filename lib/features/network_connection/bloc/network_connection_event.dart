part of 'network_connection_bloc.dart';

@immutable
abstract class NetworkConnectionEvent {}

class NetworkConnectionChanged extends NetworkConnectionEvent {
  final DataConnectionStatus status;

  NetworkConnectionChanged(this.status);
}
