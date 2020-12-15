import 'package:intensivevr_pub/core/services/image_manager.dart';

enum GameType { vr, console, board }

class Game {
  final int id;
  final String name;
  final GameType type;
  final String description;
  final List<String> pictures;
  final String category;

  Game({
    this.id,
    this.name,
    this.type,
    this.description,
    this.pictures,
    this.category,
  });

  Game.fromJson(var json)
      : id = json['id'],
        name = json['game_name'],
        type = GameType.values
            .firstWhere((e) => e.toString() == 'GameType.' + json['g_type']),
        description = json['description'],
        pictures = ImageManager.getImageUrlList(json['pics'] as List),
        category = json['game_category'];
}
