class LeaderBoardEntry {
  final int points;
  final String user;

  LeaderBoardEntry({
    this.points,
    this.user,
  });

  LeaderBoardEntry.fromJson(var json)
      : points = json['points'],
        user = json['user'];
}
