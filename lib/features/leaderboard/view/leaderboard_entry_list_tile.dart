import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/leader_board_entry.dart';

class LeaderboardEntryListTile extends StatelessWidget {
  final LeaderBoardEntry leaderboardEntry;
  final int index;
  const LeaderboardEntryListTile(this.index, this.leaderboardEntry);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(border:
          Border(bottom: BorderSide(width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$index.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(leaderboardEntry.user,style: TextStyle(fontSize: 18),),
              )),
              Text(leaderboardEntry.points.toString(),style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
