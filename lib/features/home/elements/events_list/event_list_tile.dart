import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/event.dart';

class EventListTile extends StatelessWidget {
  final Event event;
  static Color color = Colors.blue[700];

  const EventListTile({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: color, //TODO odjebać magię żeby to działało
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bottomSheet(context);
          },
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Stack(),
          ),
        ),
      ),
    );
  }

  void bottomSheet(context) {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              )
          );
        }
    );
  }
}
