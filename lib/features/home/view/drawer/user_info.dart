import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/user_data/user_data.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (BuildContext context, UserDataState state) {
            if (state.isDemoUser) {
              return Text('hello_stranger'.tr());
            } else {
              return Text('hello'.tr(namedArgs: {'name': state.username}));
            }
          },
        ),
      ),
    );
  }
}
