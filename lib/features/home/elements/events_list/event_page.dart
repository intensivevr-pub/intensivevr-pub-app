import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/event.dart';

class EventPage extends StatelessWidget {
  final Event event;

  const EventPage({Key key, this.event}) : super(key: key);

  static Route route(event) {
    return MaterialPageRoute<void>(
        builder: (_) => EventPage(
          event: event,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(event.pictures[0]),   //TODO: try switching background
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      event.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.grey[800].withAlpha(100),
                        fontSize: 32,
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      formatDate(event.date),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.grey[800].withAlpha(100),
                        fontSize: 24,
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text(
                        "Kategoria: " + event.category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.grey[800].withAlpha(100),
                          fontSize: 24,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      event.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.grey[800].withAlpha(100),
                        fontSize: 28,
                      )
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }

  List<Image> pictures() {
    List<Image> out = [];
    for (int i = 1; i < event.thumbnails.length; i++) {
      out.add(Image(image: NetworkImage(event.thumbnails[i])));
    }
    return out;
  }

  String formatDate(DateTime date) {
    return date.day.toString() + '.'
        + date.month.toString() + '.'
        + date.year.toString();
  }

}