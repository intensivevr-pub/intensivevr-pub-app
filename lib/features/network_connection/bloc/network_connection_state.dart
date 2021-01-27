part of 'network_connection_bloc.dart';

enum NetworkStatus { connected, disconnected, unknown }

@immutable
class NetworkConnectionState {
  final NetworkStatus status;

  const NetworkConnectionState(this.status);

  factory NetworkConnectionState.initial() {
    return const NetworkConnectionState(NetworkStatus.unknown);
  }

  factory NetworkConnectionState.connected() {
    return const NetworkConnectionState(NetworkStatus.connected);
  }

  factory NetworkConnectionState.disconnected() {
    return const NetworkConnectionState(NetworkStatus.disconnected);
  }
}
