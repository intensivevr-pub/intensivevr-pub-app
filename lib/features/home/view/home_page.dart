import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/bloc/home_screen_bloc.dart';
import 'package:intensivevr_pub/features/home/view/online_home_page.dart';
import 'package:intensivevr_pub/features/user_data/user_data.dart';
import 'offline_home_page.dart';

class HomePage extends StatefulWidget {
  static Route route({bool online = true, bool demo = false}) {
    return MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<UserDataBloc>(
              create: (BuildContext context) => UserDataBloc(
                  BlocProvider.of<AuthenticationBloc>(context), online, demo,)
                ..add(GetInitialUserData())),
          BlocProvider<HomeScreenBloc>(
            create: (BuildContext context) => HomeScreenBloc(online, demo),
          )
        ],
        child: HomePage(),
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    BlocProvider.of<UserDataBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (BuildContext context, state) {
        if(state.online){
          return OnlineHomePage();
        }else{
          return OfflineHomePage();
        }
      },
    );
  }
}
