import 'package:hive/hive.dart';
part 'recipes.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String imageUrl;

  @HiveField(1)
  String title;

  Item({
    required this.imageUrl,
    required this.title,
  });
}