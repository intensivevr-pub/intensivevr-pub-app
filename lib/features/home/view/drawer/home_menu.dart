import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/authentication/bloc/authentication_bloc.dart';
import 'package:intensivevr_pub/features/home/view/drawer/home_menu_option.dart';
import 'package:intensivevr_pub/features/home/view/drawer/user_info.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserInfo(),
          HomeMenuOption( title: "Option 1", onPress: () {
            Navigator.pop(context);
          }),
          HomeMenuOption( title: "Option 2", onPress: () {
            Navigator.pop(context);
          }),
          HomeMenuOption( title: "Option 3", onPress: () {
            Navigator.pop(context);
          }),
          HomeMenuOption( title: "Logout", onPress: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLogoutRequested());
          },)
        ],
      ),
    );
  }

}