import 'package:intensivevr_pub/core/services/image_manager.dart';

enum GameType { vr, console, board }

class Game {
  final int id;
  final String name;
  final GameType type;
  final String description;
  final List<String> thumbnails;
  final List<String> pictures;
  final String category;

  Game({
    this.id,
    this.name,
    this.type,
    this.description,
    this.thumbnails,
    this.pictures,
    this.category,
  });

  Game.fromJson(Map<String,dynamic> json)
      : id = int.tryParse(json['id'].toString()),
        name = json['game_name'].toString(),
        type = GameType.values
            .firstWhere((e) => e.toString() == 'GameType.${json['g_type']}'),
        description = json['description'].toString(),
        thumbnails = ImageManager.getCompressedImageUrlList(
            json['pics'] as List<dynamic>),
        pictures = ImageManager.getImageUrlList(json['pics'] as List<dynamic>),
        category = json['game_category'].toString();
}
