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

  User.fromJson(Map<String,dynamic> json)
      : points = int.tryParse(json['points'].toString()),
        hash = json['userhash'].toString(),
        isDemoUser = false,
        name = json['nick'].toString();
}
