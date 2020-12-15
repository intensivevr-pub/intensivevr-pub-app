import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/event.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/view/generic_tile.dart';

class EventListTile extends GenericListTile {
  final Event event;

  const EventListTile({Key key, this.event}) : super(key: key);

  @override
  Widget setMainContent() {
    return Container();
  }

  @override
  List<Widget> setSheetContent() {
    return [Container()];
  }
}
