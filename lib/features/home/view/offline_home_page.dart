import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/features/home/bloc/home_screen_bloc.dart';
import 'package:intensivevr_pub/features/network_connection/bloc/network_connection_bloc.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        child: BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (!state.refreshing) {
              _refreshController.refreshCompleted();
            }
          },
          child: Scaffold(
            //TODO poprawić design
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
                      const Text("Nie masz połączenia z internetem"),
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) {
                          if (state.isDemoUser) {
                            return BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: "Tutaj bedzie Twoj kod",
                              // Content
                              width: width * 0.7,
                              height: 130,
                            );
                          } else {
                            return BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: state.hash,
                              // Content
                              width: width * 0.7,
                              height: 130,
                            );
                          }
                        },
                      ),
                      RaisedButton(
                        onPressed: () => onRefresh(
                            isOnline: state.status == NetworkStatus.connected),
                        child: const Text("Odśwież"),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
