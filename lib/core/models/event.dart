import 'package:intensivevr_pub/core/services/image_manager.dart';

class Event {
  final String name;
  final int id;
  final String description;
  final List<String> thumbnails;
  final List<String> pictures;
  final DateTime date;
  final String category;

  Event({
    this.name,
    this.id,
    this.description,
    this.thumbnails,
    this.pictures,
    this.date,
    this.category,
  });

  Event.fromJson(var json)
      : name = json['event_name'],
        id = json['id'],
        description = json['description'],
        thumbnails = ImageManager.getCompressedImageUrlList(json['pics'] as List),
        pictures = ImageManager.getImageUrlList(json['pics'] as List),
        date = DateTime.parse(json['event_date']),
        category = json['event_category'];
}
