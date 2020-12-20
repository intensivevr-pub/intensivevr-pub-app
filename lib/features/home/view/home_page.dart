import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/elements/elements.dart';
import 'package:intensivevr_pub/features/user_data/user_data.dart';

import 'drawer/home_menu.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                UserDataBloc(BlocProvider.of<AuthenticationBloc>(context))
                  ..add(GetInitialUserData()),
            child: HomePage()));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationBloc authBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xFF6A11CB),
      child: SafeArea(
        child: BackdropScaffold(
          inactiveOverlayOpacity: 0,
          backLayerBackgroundColor: Colors.grey[100],
          drawer: HomeMenu(),
          headerHeight: height - 300,
          appBar: AppBar(
            iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.grey[100],
            actions: [
              BackdropToggleButton(
                icon: AnimatedIcons.list_view,
                color: Colors.black,
              )
            ],
          ),
          backLayer: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: BlocBuilder<UserDataBloc, UserDataState>(
              builder: (BuildContext context, UserDataState state) {
                return BarcodeWidget(
                  barcode: Barcode.code128(), // Barcode type and settings
                  data: state.hash, // Content
                  width: width * 0.7,
                  height: 130,
                );
              },
            ),
          ),
          frontLayer: Padding(
            padding: EdgeInsets.only(top: 7.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return false;
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (BuildContext context, UserDataState state) {
                          return PointsPanel(points: state.points);
                        },
                      ),
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (BuildContext context, UserDataState state) {
                          if (state.activeCoupons.length > 0) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.green,
                                        Colors.green.withAlpha(0)
                                      ],
                                      stops: [.35, 1],
                                    )),
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Aktywowane kupony:",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CouponListTile(
                                              coupon:
                                              state.activeCoupons[index]);
                                        },
                                        itemCount: state.activeCoupons.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      BlocProvider<GenericListBloc>(
                          create: (BuildContext context) {
                            return new GenericListBloc(
                              authBloc: authBloc,
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
                            return new GenericListBloc(
                              authBloc: authBloc,
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
                            return new GenericListBloc(
                              authBloc: authBloc,
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
                            return new GenericListBloc(
                              authBloc: authBloc,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
