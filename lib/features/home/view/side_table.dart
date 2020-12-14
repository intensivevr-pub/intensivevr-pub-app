import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SideTable extends StatelessWidget {
  final String title;
  final Color color;

  const SideTable({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color, color.withAlpha(0)],
            stops: [.35, 1],
          )
        ),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 200,
              // TODO: change to listview builder, add to parameers
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

}