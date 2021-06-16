import 'package:epidemic_alarm/src/feature/map/regions/controller/resolution_startegy.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/src/models/geopoint.dart';

class LowResolution implements ResolutionStartegy {
  final String _fileName = 'assets/wojewodztwa-min.geojson';

  @override
  String getFileName() {
    return _fileName;
  }

  @override
  List<GeoPoint> getGeoPoints(dynamic geometry) {
    return (geometry as GeoJsonPolygon).geoSeries.first.geoPoints;
  }

}