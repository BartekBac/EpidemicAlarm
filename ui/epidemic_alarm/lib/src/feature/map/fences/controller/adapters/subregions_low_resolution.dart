import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/resolution_startegy.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';

class SubregionsLowResolution implements ResolutionStartegy {
  final String _fileName = 'assets/powiaty-min.geojson';

  @override
  String getFileName() {
    return _fileName;
  }

  @override
  GeoSerie getGeoSerie(dynamic geometry) {
    if(geometry is GeoJsonPolygon)
      return geometry.geoSeries.first;
    else
      return (geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first;
  }

}