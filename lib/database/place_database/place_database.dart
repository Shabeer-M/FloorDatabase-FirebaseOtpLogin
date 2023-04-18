import 'package:floor/floor.dart';
import 'package:places/database/dao/place_dao.dart';
import 'package:places/database/entity/place.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'place_database.g.dart';
@Database(version:1,entities:[Place])
abstract class AppDatabase extends FloorDatabase{
  PlaceDao get placeDao;
}
