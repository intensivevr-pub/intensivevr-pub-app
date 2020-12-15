import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/event.dart';
import 'package:intensivevr_pub/features/home/elements/events_list/event_page.dart';

class EventListTile extends StatelessWidget {
  final Event event;
  static Color color = Colors.blue[700];

  const EventListTile({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(event.pictures[0]),
          fit: BoxFit.cover,
        ) ,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(context, EventPage.route(event));
          },
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Stack(
                children : [
                  Container(
                    color: Colors.grey[800].withAlpha(100),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        event.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.grey[800].withAlpha(100),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          formatDate(event.date),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    )
                  ),

                ],
              ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return date.day.toString() + '.'
        + date.month.toString() + '.'
        + date.year.toString();
  }

}
