import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/app.dart';
import 'package:intensivevr_pub/features/network_connection/bloc/network_connection_bloc.dart';
import 'package:intensivevr_pub/features/theme/bloc/bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    print(error);
  }
}

void main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pl')],
      path: 'assets/translations',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('pl'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (BuildContext context) =>
                ThemeBloc()..add(ThemeLoadStarted()),
          ),
          BlocProvider<NetworkConnectionBloc>(
              create: (BuildContext context) => NetworkConnectionBloc()),
        ],
        child: App(authenticationRepository: AuthenticationRepository()),
      ),
    ),
  );
}
