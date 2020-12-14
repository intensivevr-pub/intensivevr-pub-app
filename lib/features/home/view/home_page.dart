import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/view/point_show.dart';

import 'side_table.dart';
import 'home_menu.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;

  void loadPoints() async {
    var test = await DataRepository.getUserPoints(
        BlocProvider.of<AuthenticationBloc>(context));
    setState(() {
      data = test;
    });
  }

  @override
  void initState() {
    loadPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeMenu(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => SimpleDialog(
                  title: Text("ID"),
                ),
                barrierDismissible: true,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PointShow(points: data ?? -1),
            SideTable(title: "Aktualne Promocje", color: Colors.grey[500]),
            SideTable(title: "Dostępne gry:", color: Colors.purple[900]),
            SideTable(title: "Wymieniaj punkty:", color: Colors.orange[300]),
            SideTable(title: "Nadchodzące wydarzenia:", color: Colors.green[900]),
          ],
        ),
      ),
    );
  }
}
