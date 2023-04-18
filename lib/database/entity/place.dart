import 'package:floor/floor.dart';

@entity
class Place{
  @PrimaryKey(autoGenerate:true)
  final int id;
  final String image;
  final String title;
  final String description;
  Place({required this.id,required this.image, required this.title,required this.description});
}