import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/elements/elements_list/elements_list.dart';
import 'package:intensivevr_pub/features/home/view/point_show.dart';

import 'home_menu.dart';
import 'side_table.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  AuthenticationBloc authBloc;

  void loadPoints() async {
    var test = await DataRepository.getUserPoints(
        BlocProvider.of<AuthenticationBloc>(context));
    setState(() {
      data = test;
    });
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    loadPoints();
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
          headerHeight: height-300,
          appBar: AppBar(
            iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.grey[100],
            actions: [
              BackdropToggleButton(
                icon: AnimatedIcons.list_view,color: Colors.black,
              )
            ],
          ),
          backLayer: Padding(
            padding:  EdgeInsets.only(top:50.0),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: 'HUJE MUJE', // Content
              width: width*0.7,
              height: 130,
            ),
          ),
          frontLayer: Padding(
            padding: EdgeInsets.only(top:7.0),
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
                      PointShow(points: data ?? -1),
                      BlocProvider<ElementsListBloc>(
                          create: (BuildContext context) {
                            return new ElementsListBloc(
                              authBloc: authBloc,
                              method: DataRepository.getPrizes,
                              portion: 5,
                            )..add(ReachedBottomOfList());
                          },
                          child: SideTable(
                              title: "Wymieniaj punkty:",
                              type: PanelType.prize,
                              color: Colors.orange[300])),
                      BlocProvider<ElementsListBloc>(
                          create: (BuildContext context) {
                            return new ElementsListBloc(
                              authBloc: authBloc,
                              method: DataRepository.getDiscounts,
                              portion: 5,
                            )..add(ReachedBottomOfList());
                          },
                          child: SideTable(
                              title: "Aktualne Promocje",
                              type: PanelType.discounts,
                              color: Colors.grey[500])),
                      BlocProvider<ElementsListBloc>(
                          create: (BuildContext context) {
                            return new ElementsListBloc(
                              authBloc: authBloc,
                              method: DataRepository.getGames,
                              portion: 5,
                            )..add(ReachedBottomOfList());
                          },
                          child: SideTable(
                              title: "Dostępne gry:",
                              type: PanelType.game,
                              color: Colors.purple[900])),
                      BlocProvider<ElementsListBloc>(
                          create: (BuildContext context) {
                            return new ElementsListBloc(
                              authBloc: authBloc,
                              method: DataRepository.getEvents,
                              portion: 5,
                            )..add(ReachedBottomOfList());
                          },
                          child: SideTable(
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
