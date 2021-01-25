import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/features/leaderboard/leaderboard.dart';

class LeaderboardGameListTile extends StatelessWidget {
  final Game game;

  const LeaderboardGameListTile({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, LeaderboardPage.route(game));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(width: 0.6)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: game.id,
                child: Container(
                  width: 179,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(game.thumbnails[0])),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  game.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
