import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/leader_board_entry.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';

import 'leaderboard_entry_list_tile.dart';

class LeaderboardPage extends StatefulWidget {
  static Route route(Game game) {
    return MaterialPageRoute<void>(builder: (_) => LeaderboardPage(game: game));
  }

  final Game game;

  const LeaderboardPage({Key key, this.game}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<LeaderBoardEntry> entries = [];
  bool loaded = false;

  Future<bool> fillWithData() async {
    entries = await DataRepository.getLeaderboard(widget.game, 10);
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
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: Hero(
              tag: widget.game.id,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.game.pictures[0]),
                        fit: BoxFit.fitWidth)),
              )),
          expandedHeight: 200,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          sliver: loaded
              ? entries.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => LeaderboardEntryListTile(index+1,entries[index]),
                        childCount: entries.length,
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: Center(
                        child: Text("Brak wyników dla tej gry",style: TextStyle(fontSize: 20),),
                      ),
                    )
              : const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ],
    ));
  }
}
/*
loaded
          ? entries.length != 0
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Text(entries[index].user +
                        ": " +
                        entries[index].points.toString());
                  },
                  itemCount: entries.length,
                )
              : Center(
                  child: Text("Brak wyników dla tej gry"),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
 */
