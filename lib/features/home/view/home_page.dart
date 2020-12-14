import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/view/point_show.dart';

import 'discounts.dart';
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Builder(
            builder: (context) {
              final userId = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user.authToken,
              );
              return PointShow(points: data ?? -1);
            },
          ),
          Discounts(),
        ],
      ),
    );
  }
}
