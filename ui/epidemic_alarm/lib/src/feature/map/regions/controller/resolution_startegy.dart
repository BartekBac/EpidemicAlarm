import 'package:geopoint/geopoint.dart';

abstract class ResolutionStartegy {
  List<GeoPoint> getGeoPoints(dynamic geometry);
  String getFileName();
}