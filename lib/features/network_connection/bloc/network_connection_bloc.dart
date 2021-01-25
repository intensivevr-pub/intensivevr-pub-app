import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';

part 'network_connection_event.dart';

part 'network_connection_state.dart';

class NetworkConnectionBloc
    extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {
  StreamSubscription<DataConnectionStatus> _networkStatusSubscription;

  NetworkConnectionBloc() : super(NetworkConnectionState.initial()) {
    _networkStatusSubscription = DataConnectionChecker()
        .onStatusChange
        .listen((status) => add(NetworkConnectionChanged(status)));
  }

  @override
  Stream<NetworkConnectionState> mapEventToState(
      NetworkConnectionEvent event) async* {
    if (event is NetworkConnectionChanged) {
      if (event.status == DataConnectionStatus.connected) {
        print("CONNECTED");
        yield NetworkConnectionState.connected();
      } else {
        print("DISCONNECTED");
        yield NetworkConnectionState.disconnected();
      }
    }
  }

  @override
  Future<void> close() {
    _networkStatusSubscription?.cancel();
    return super.close();
  }
}
