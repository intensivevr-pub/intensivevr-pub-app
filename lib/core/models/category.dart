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
}
