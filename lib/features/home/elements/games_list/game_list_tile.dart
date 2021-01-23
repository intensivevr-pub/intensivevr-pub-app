import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/game.dart';

import 'game_page.dart';

class GameListTile extends StatelessWidget {
  final Game game;
  static Color color = Colors.blue[700];

  const GameListTile({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 290.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(game.thumbnails[0]),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(context, GamePage.route(game));
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Container(
                color: Colors.grey[900].withAlpha(100),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    game.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,

                    ),
                  ),
                ),
              ),

            )
          ),
        ),
      ),
    );
  }
}
