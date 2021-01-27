import 'package:backdrop/backdrop.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/bloc/home_screen_bloc.dart';
import 'package:intensivevr_pub/features/home/elements/elements.dart';
import 'package:intensivevr_pub/features/network_connection/network_connection.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'drawer/home_menu.dart';

class OnlineHomePage extends StatefulWidget {
  @override
  _OnlineHomePageState createState() => _OnlineHomePageState();
}

class _OnlineHomePageState extends State<OnlineHomePage> {
  final RefreshController _refreshController = RefreshController();

  // ignore: close_sinks
  AuthenticationBloc authBloc;

  void onRefresh({bool isOnline}) {
    BlocProvider.of<HomeScreenBloc>(context)
        .add(RefreshRequested(online: isOnline));
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (!state.refreshing) {
          _refreshController.refreshCompleted();
        } else {
          BlocProvider.of<UserDataBloc>(context).add(RefreshPointsAndRewards());
        }
      },
      child: Container(
        color: kPurpleGradientColor,
        child: SafeArea(
          child: BlocBuilder<UserDataBloc, UserDataState>(
              builder: (context, userState) {
            return BackdropScaffold(
              floatingActionButton: userState.isDemoUser
                  ? InkWell(
                      onTap: () {},
                      child: Container(
                          height: 50,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          child: const Center(child: Text("Tryb demo"))),
                    )
                  : null,
              inactiveOverlayOpacity: 0,
              backLayerBackgroundColor: Theme.of(context).backgroundColor,
              drawer: HomeMenu(),
              headerHeight: height - 300,
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                iconTheme: Theme.of(context).iconTheme,
                actions: [
                  BackdropToggleButton(
                    color: Theme.of(context).toggleButtonsTheme.color,
                    icon: AnimatedIcons.list_view,
                  )
                ],
              ),
              backLayer: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (BuildContext context, UserDataState state) {
                    if (state.isDemoUser) {
                      return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(12),
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: "Tutaj będzie Twój kod",
                          width: width * 0.7,
                          height: 130,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      if (state != null && state.hash != null) {
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
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
              ),
              frontLayer: Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowGlow();
                      return false;
                    },
                    child: BlocBuilder<NetworkConnectionBloc,
                            NetworkConnectionState>(
                        builder: (context, networkState) {
                      return SmartRefresher(
                        onRefresh: () => onRefresh(
                            isOnline:
                                networkState.status == NetworkStatus.connected),
                        controller: _refreshController,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              BlocBuilder<UserDataBloc, UserDataState>(
                                builder: (BuildContext context,
                                    UserDataState state) {
                                  if (state.isDemoUser) {
                                    return const PointsPanel(
                                      points: -1,
                                      demo: true,
                                    );
                                  } else {
                                    if (state.points != null) {
                                      return PointsPanel(points: state.points);
                                    } else {
                                      return const PointsPanel(points: -1);
                                    }
                                  }
                                },
                              ),
                              BlocBuilder<UserDataBloc, UserDataState>(
                                builder: (BuildContext context,
                                    UserDataState state) {
                                  if (state != null &&
                                      !state.isDemoUser &&
                                      state.activeCoupons != null &&
                                      state.activeCoupons.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.green,
                                            Colors.green.withAlpha(0)
                                          ],
                                          stops: const [.35, 1],
                                        )),
                                        height: 250,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.all(12.0),
                                              child: Text(
                                                "Aktywowane kupony:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 200,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CouponListTile(
                                                      coupon:
                                                          state.activeCoupons[
                                                              index]);
                                                },
                                                itemCount:
                                                    state.activeCoupons.length,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              BlocProvider<GenericListBloc>(
                                  create: (BuildContext context) {
                                    return GenericListBloc(
                                      method: DataRepository.getPrizes,
                                      portion: 5,
                                    )..add(ReachedBottomOfList());
                                  },
                                  child: GenericPanel(
                                      title: "Wymieniaj punkty:",
                                      type: PanelType.prize,
                                      color: Colors.orange[300])),
                              BlocProvider<GenericListBloc>(
                                  create: (BuildContext context) {
                                    return GenericListBloc(
                                      method: DataRepository.getDiscounts,
                                      portion: 5,
                                    )..add(ReachedBottomOfList());
                                  },
                                  child: GenericPanel(
                                      title: "Aktualne Promocje",
                                      type: PanelType.discounts,
                                      color: Colors.grey[500])),
                              BlocProvider<GenericListBloc>(
                                  create: (BuildContext context) {
                                    return GenericListBloc(
                                      method: DataRepository.getGames,
                                      portion: 5,
                                    )..add(ReachedBottomOfList());
                                  },
                                  child: GenericPanel(
                                      title: "Dostępne gry:",
                                      type: PanelType.game,
                                      color: Colors.purple[900])),
                              BlocProvider<GenericListBloc>(
                                  create: (BuildContext context) {
                                    return GenericListBloc(
                                      method: DataRepository.getEvents,
                                      portion: 5,
                                    )..add(ReachedBottomOfList());
                                  },
                                  child: GenericPanel(
                                      title: "Nadchodzące wydarzenia:",
                                      type: PanelType.event,
                                      color: Colors.green[900])),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
