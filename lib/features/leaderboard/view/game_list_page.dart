import 'package:flutter/material.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
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

  Future<bool> fillWithData() async {
    listOfGames = await DataRepository.getGames(0, null);
    setState(() {
      loaded = true;
    });
    return true;
  }

  @override
  void initState() {
    fillWithData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPurpleGradientColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            title: Text("Wybierz grę", style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
            body: loaded
                ? listOfGames.isNotEmpty
                    ? ListView.builder(
                        itemCount: listOfGames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LeaderboardGameListTile(game: listOfGames[index],);
                        },
                      )
                    : const Center(
                        child: Text("Brak Gier"),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
