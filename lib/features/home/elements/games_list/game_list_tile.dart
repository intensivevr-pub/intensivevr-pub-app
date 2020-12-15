import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/view/generic_tile.dart';

class GameListTile extends GenericListTile {
  final Game game;

  const GameListTile({Key key, this.game}) : super(key: key);

  @override
  Widget setMainContent() {
    return Container();
  }

  @override
  List<Widget> setSheetContent() {
    return [Container()];
  }
}
