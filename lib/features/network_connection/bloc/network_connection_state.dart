part of 'network_connection_bloc.dart';

enum NetworkStatus { connected, disconnected, unknown }

@immutable
class NetworkConnectionState {
  final NetworkStatus status;

  NetworkConnectionState(this.status);

  factory NetworkConnectionState.initial() {
    return NetworkConnectionState(NetworkStatus.unknown);
  }

  factory NetworkConnectionState.connected() {
    return NetworkConnectionState(NetworkStatus.connected);
  }

  factory NetworkConnectionState.disconnected() {
    return NetworkConnectionState(NetworkStatus.disconnected);
  }
}
