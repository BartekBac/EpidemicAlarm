import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ZoneMarkerController {
  var _circleMarkers = <CircleMarker>[];
  get circleMarkers => _circleMarkers;

  ZoneMarkerController() {
    _circleMarkers.add(
      _createMarker(0, 0, 0)
    );
  }

  CircleMarker _createMarker(double lat, double lng, double range) {
    return new CircleMarker(
        point: LatLng(lat, lng),
        color: Colors.red.withOpacity(0.7),
        borderColor: Colors.red,
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: range // meters
    );
  }

  CircleMarker _createCursorMarker(double lat, double lng, double range) {
    return new CircleMarker(
        point: LatLng(lat, lng),
        color: Colors.grey.withOpacity(0.3),
        borderColor: Colors.grey.withOpacity(0.7),
        borderStrokeWidth: 3,
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

  void updateCursorMarker(double lat, double lng, double range) {
    if(_circleMarkers.length > 1) {
      _circleMarkers.removeRange(1, _circleMarkers.length);
    }
    _circleMarkers.add(
        _createCursorMarker(lat, lng, range)
    );
  }

}