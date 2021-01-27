class LeaderBoardEntry {
  final int points;
  final String user;

  LeaderBoardEntry({
    this.points,
    this.user,
  });

  LeaderBoardEntry.fromJson(Map<String,dynamic> json)
      : points = int.tryParse(json['points'].toString()),
        user = json['user'].toString();
}
