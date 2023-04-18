import 'package:floor/floor.dart';
import 'package:places/database/entity/place.dart';

@dao
abstract class PlaceDao {
  @Query('SELECT * FROM Place')
  Stream<List<Place>> getAllPlace();

  @insert
  Future<void>insertPlace(Place place);
}
