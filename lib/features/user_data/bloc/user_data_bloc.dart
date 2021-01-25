import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/core/services/shared_preferences.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';

import 'bloc.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AuthenticationBloc authBloc;
  final bool online;
  final bool demo;

  UserDataBloc(this.authBloc, this.online, this.demo)
      : super(UserDataState.initial());

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is GetInitialUserData) {
      if (online) {
        if (demo) {
          yield UserDataState(
              username: null,
              points: null,
              hash: null,
              activeCoupons: null,
              isDemoUser: true,
              loaded: true);
        } else {
          try {
            User user = await DataRepository.getUserData(authBloc);
            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserInfo(user);
            List<Coupon> activeCoupons =
                await DataRepository.getActiveCoupons(authBloc);
            yield UserDataState(
              username: user.name,
              points: user.points,
              hash: user.hash,
              activeCoupons: activeCoupons,
              isDemoUser: user.isDemoUser,
              loaded: true,
            );
          } catch (e) {
            yield UserDataError();
          }
        }
      } else {
        final sharedPrefService = await SharedPreferencesService.instance;
        User user = User(
            name: sharedPrefService.userName, hash: sharedPrefService.userHash);
        yield UserDataState(
            username: user.name,
            points: null,
            hash: user.hash,
            activeCoupons: null,
            isDemoUser: false,
            loaded: true);
      }
    } else if (event is RefreshPointsAndRewards) {
      try {
        int points = await DataRepository.getUserPoints(authBloc);
        List<Coupon> activeCoupons =
            await DataRepository.getActiveCoupons(authBloc);
        yield state.copyWith(points: points, activeRewards: activeCoupons);
      } catch (e) {
        print("error");
      }
    }
  }
}
