import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:meta/meta.dart';

part 'prize_event.dart';

part 'prize_state.dart';

class PrizeBloc extends Bloc<PrizeEvent, PrizeState> {
  final AuthenticationBloc authBloc;
  final Prize prize;

  PrizeBloc(this.authBloc, this.prize) : super(InitialPrizeState());

  @override
  Stream<PrizeState> mapEventToState(PrizeEvent event) async* {
    if (event is CollectPrizeButtonPressed) {
      yield LoadingPrizeRealization();
      bool response;
      try {
        response = await DataRepository.postRewardCollect(authBloc, prize.id);
      } on Exception {
        print(Exception);
        yield PrizeCollectionError();
        return;
      }
      if (response) {
        yield PrizeCollected();
      } else {
        yield PrizeCollectionError();
      }
    }
  }
}
