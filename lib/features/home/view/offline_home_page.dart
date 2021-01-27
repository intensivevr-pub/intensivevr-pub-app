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
    double width = MediaQuery
        .of(context)
        .size
        .width;
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
            body: BlocConsumer<NetworkConnectionBloc, NetworkConnectionState>(
                listener: (context, state) {
                  if (state.status == NetworkStatus.connected) {
                    onRefresh(true);
                  }
                }, builder: (context, state) {
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
                            if (state.isDemoUser) {
                              return Container(
                                  padding: const EdgeInsets.all(12.0),
                                  color: Colors.white,
                                  child: BarcodeWidget(
                                    barcode: Barcode.code128(),
                                    data: "tutaj bedzie Twoj kod",
                                    width: width * 0.7,
                                    height: 130,
                                    color: Colors.black,
                                    style: TextStyle(color: Colors.black),
                            ));
                            }else{
                            return Container(
                                  padding: const EdgeInsets.all(12.0),
                                  color: Colors.white,
                                  child: BarcodeWidget(
                                    barcode: Barcode.code128(),
                                    data: state.hash,
                                    width: width * 0.7,
                                    height: 130,
                                    color: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                  )
                            );
                            }
                          },
                        ),
                        RaisedButton(
                          onPressed: () =>
                              onRefresh(
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
