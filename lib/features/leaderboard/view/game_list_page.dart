import 'package:flutter/material.dart';
import 'package:intensivevr_pub/app.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/home/elements/games_list/game_list_tile.dart';
import 'package:intensivevr_pub/features/leaderboard/view/leaderboard_game_list_tile.dart';

class GameListPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GameListPage());
  }
  @override
  _GameListPageState createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  List<Game> listOfGames = [];
  bool loaded = false;

  void fillWithData() async {
    listOfGames = await DataRepository.getGames(0, null);
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    fillWithData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6A11CB),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text("Wybierz grę",style: TextStyle(color: Colors.black),),
          ),
            body: loaded
                ? listOfGames.length != 0
                    ? ListView.builder(
                        itemCount: listOfGames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LeaderboardGameListTile(game: listOfGames[index],);
                        },
                      )
                    : Center(
                        child: Text("Brak Gier"),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
