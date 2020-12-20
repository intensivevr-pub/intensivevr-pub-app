class User {
  final bool isDemoUser;
  final int points;
  final String name;
  final String hash;

  User({
    this.points,
    this.name,
    this.hash,
    this.isDemoUser,
  });

  User.fromJson(var json)
      : points = json['points'],
        hash = json['userhash'],
        isDemoUser = false, //TODO solve with backend
        name = json['nick'];
}
