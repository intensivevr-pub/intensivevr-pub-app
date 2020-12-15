class User {
  final int id;
  final int points;
  final String name;

  User({
    this.id,
    this.points,
    this.name,
  });

  User.fromJson(var json)
      : id = json['id'],
        points = json['points'],
        name = json['name'];
}
