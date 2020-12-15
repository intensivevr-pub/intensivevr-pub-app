import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/view/generic_tile.dart';

class PrizeListTile extends GenericListTile {
  final Prize prize;

  const PrizeListTile({Key key, this.prize}) : super(key: key);

  @override
  Widget setMainContent() {
    return Container();
  }

  @override
  List<Widget> setSheetContent() {
    return [Container()];
  }
}
