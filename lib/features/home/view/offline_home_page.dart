import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/home/bloc/home_screen_bloc.dart';
import 'package:intensivevr_pub/features/network_connection/bloc/network_connection_bloc.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfflineHomePage extends StatefulWidget {
  @override
  _OfflineHomePageState createState() => _OfflineHomePageState();
}

class _OfflineHomePageState extends State<OfflineHomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh(bool isOnline) {
    BlocProvider.of<HomeScreenBloc>(context).add(RefreshRequested(isOnline));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xFF6A11CB),
      child: SafeArea(
        child: BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (!state.refreshing) {
              _refreshController.refreshCompleted();
            }
          },
          child: Scaffold(
            //TODO poprawić design
            body: BlocBuilder<NetworkConnectionBloc, NetworkConnectionState>(
                builder: (context, state) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () =>
                    onRefresh(state.status == NetworkStatus.connected),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Nie masz połączenia z internetem"),
                        BlocBuilder<UserDataBloc, UserDataState>(
                          builder: (context, state) {
                            return BarcodeWidget(
                              barcode: Barcode.code128(),
                              // Barcode type and settings
                              data: state.hash,
                              // Content
                              width: width * 0.7,
                              height: 130,
                            );
                          },
                        ),
                        RaisedButton(
                          onPressed: () => onRefresh(
                              state.status == NetworkStatus.connected),
                          child: Text("Odśwież"),
                        )
                      ],
                    ),
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
