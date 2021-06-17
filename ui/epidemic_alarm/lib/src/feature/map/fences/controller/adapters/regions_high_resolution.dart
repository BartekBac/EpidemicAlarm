import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/resolution_startegy.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';

class RegionsHighResolution implements ResolutionStartegy {
  final String _fileName = 'assets/wojewodztwa-max.geojson';

  @override
  String getFileName() {
    return _fileName;
  }

  @override
  GeoSerie getGeoSerie(dynamic geometry) {
    return (geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first;
  }

}