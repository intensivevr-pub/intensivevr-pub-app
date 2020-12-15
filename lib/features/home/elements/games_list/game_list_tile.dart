import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/view/generic_tile.dart';

class GameListTile extends GenericListTile {
  final Game game;

  const GameListTile({Key key, this.game}) : super(key: key);

  @override
  Widget setMainContent() {
    return Stack(
      children: [
        Text(
          game.name ?? "maselko",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image(
                image: NetworkImage(game.pictures[0]),
              height: 110,
            ))
      ],
    );
  }

  @override
  List<Widget> setSheetContent() {
    return [Container()];
  }
}
