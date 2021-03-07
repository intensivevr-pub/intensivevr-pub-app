import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/authentication/bloc/authentication_bloc.dart';
import 'package:intensivevr_pub/features/home/view/drawer/home_menu_option.dart';
import 'package:intensivevr_pub/features/home/view/drawer/user_info.dart';
import 'package:intensivevr_pub/features/leaderboard/view/game_list_page.dart';
import 'package:intensivevr_pub/features/products/view/products_page.dart';
import 'package:intensivevr_pub/widgets/complex/complex.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserInfo(),
          ListTile(
            title: Text('change_mode'.tr()),
            trailing: ThemeSwitcher(),
          ),
          HomeMenuOption(
              title: 'leaderboard'.plural(2),
              onPress: () {
                Navigator.push(context, GameListPage.route());
              }),
          HomeMenuOption(
              title: 'offer'.tr(),
              onPress: () {
                Navigator.push(context, ProductsPage.route());
              }),
          HomeMenuOption(
            title: 'logout'.tr(),
            onPress: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLogoutRequested());
            },
          )
        ],
      ),
    );
  }
}
