import 'category.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String picture;
  final double price;
  final Category category;

  Product({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.price,
    this.category,
  });
}
