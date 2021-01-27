enum CategoryType { event, game, product }

class Category {
  final int id;
  final String name;
  final CategoryType type;
  final String picture;

  Category({
    this.name,
    this.type,
    this.picture,
    this.id,
  });

  Category.fromJson(Map<String,dynamic> json)
      : name = json['category_name'].toString(),
        type = CategoryType.values
            .firstWhere((e) => e.toString() == 'CategoryType.${json['ctype']}'),
        picture = json['picture'].toString(),
        id = int.tryParse(json['id'].toString());
}
