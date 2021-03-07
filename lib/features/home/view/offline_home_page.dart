import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/features/home/bloc/home_screen_bloc.dart';
import 'package:intensivevr_pub/features/network_connection/bloc/network_connection_bloc.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'drawer/home_menu.dart';

class OfflineHomePage extends StatefulWidget {
  @override
  _OfflineHomePageState createState() => _OfflineHomePageState();
}

class _OfflineHomePageState extends State<OfflineHomePage> {
  final RefreshController _refreshController = RefreshController();

  void onRefresh({bool isOnline}) {
    BlocProvider.of<HomeScreenBloc>(context)
        .add(RefreshRequested(online: isOnline));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      color: kPurpleGradientColor,
      child: SafeArea(
        child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (!state.refreshing) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, HomeScreenState homeState) {
            return Scaffold(
              drawer: HomeMenu(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                iconTheme: Theme.of(context).iconTheme,
              ),
              body: BlocConsumer<NetworkConnectionBloc, NetworkConnectionState>(
                  listener: (context, state) {
                if (state.status == NetworkStatus.connected) {
                  onRefresh(isOnline: true);
                }
              }, builder: (context, state) {
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () => onRefresh(
                      isOnline: state.status == NetworkStatus.connected),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'no_connection_1'.tr(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              'no_connection_2'.tr(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        BlocBuilder<UserDataBloc, UserDataState>(
                          builder: (context, state) {
                            if (state.isDemoUser) {
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(12),
                                child: BarcodeWidget(
                                  barcode: Barcode.code128(),
                                  data: 'demo_barcode'.tr(),
                                  width: width * 0.7,
                                  height: 130,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            } else {
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(12),
                                child: BarcodeWidget(
                                  barcode: Barcode.code128(),
                                  data: state.hash,
                                  width: width * 0.7,
                                  height: 130,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide()),
                          onPressed: () => onRefresh(
                              isOnline:
                                  state.status == NetworkStatus.connected),
                          child: SizedBox(
                            width: 170,
                            height: 50,
                            child: Center(
                              child: !homeState.refreshing
                                  ? Text(
                                      'refresh'.tr(),
                                      style: const TextStyle(fontSize: 24),
                                    )
                                  : const CircularProgressIndicator(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
