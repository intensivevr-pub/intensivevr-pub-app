class User {
  final int points;
  final String name;
  final String hash;

  User({
    this.points,
    this.name,
    this.hash,
  });

  User.fromJson(var json)
      : points = json['points'],
        hash = json['userhash'],
        name = json['nick'];
}
