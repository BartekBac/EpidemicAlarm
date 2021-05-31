import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ZoneMarkerController {
  var _circleMarkers = <CircleMarker>[];
  get circleMarkers => _circleMarkers;

  CircleMarker _createMarker(double lat, double lng, double range) {
    return new CircleMarker(
        point: LatLng(lat, lng),
        color: Colors.blue.withOpacity(0.7),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: range // meters
    );
  }

  void updateCircleMarker(double lat, double lng, double range) {
    _circleMarkers.clear();
    _circleMarkers.add(
        _createMarker(lat, lng, range)
    );
  }

}