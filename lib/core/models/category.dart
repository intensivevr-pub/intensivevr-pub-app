enum CategoryType { event, game, product }

class Category {
  final int id;
  final String name;
  final CategoryType type;
  final picture;

  Category({
    this.name,
    this.type,
    this.picture,
    this.id,
  });

  Category.fromJson(var json)
      : name = json['category_name'],
        type = json['ctype'],
        picture = json['picture'],
        id = json['id'];
}
