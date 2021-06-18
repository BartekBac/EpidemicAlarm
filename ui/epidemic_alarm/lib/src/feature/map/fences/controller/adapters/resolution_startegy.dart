import 'package:geopoint/geopoint.dart';

abstract class ResolutionStartegy {
  GeoSerie getGeoSerie(dynamic geometry);
  String getFileName();
}