import 'package:epidemic_alarm/src/feature/map/regions/controller/resolution_startegy.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/src/models/geopoint.dart';

class HighResolution implements ResolutionStartegy {
  final String _fileName = 'assets/wojewodztwa-max.geojson';

  @override
  String getFileName() {
    return _fileName;
  }

  @override
  List<GeoPoint> getGeoPoints(dynamic geometry) {
    return (geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first.geoPoints;
  }

}