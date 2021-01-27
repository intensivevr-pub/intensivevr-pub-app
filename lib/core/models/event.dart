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

  Event.fromJson(Map<String,dynamic> json)
      : name = json['event_name'].toString(),
        id = int.tryParse(json['id'].toString()),
        description = json['description'].toString(),
        thumbnails = ImageManager.getCompressedImageUrlList(
            json['pics'] as List<dynamic>),
        pictures = ImageManager.getImageUrlList(json['pics'] as List<dynamic>),
        date = DateTime.parse(json['event_date'].toString()),
        category = json['event_category'].toString();
}
