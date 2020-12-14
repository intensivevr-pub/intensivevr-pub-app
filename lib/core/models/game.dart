import 'category.dart';

enum GameType { vr, console, board }

class Game {
  final int id;
  final String name;
  final GameType type;
  final String description;
  final List<String> pictures;
  final Category category;

  Game({
    this.id,
    this.name,
    this.type,
    this.description,
    this.pictures,
    this.category,
  });
}
