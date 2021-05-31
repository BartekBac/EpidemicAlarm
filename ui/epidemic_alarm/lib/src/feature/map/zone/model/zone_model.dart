import 'package:epidemic_alarm/src/logic/GeolocationService.dart';
import 'package:epidemic_alarm/src/utility/configuration.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class ZoneModel extends ChangeNotifier {
  static final List<double> rangeSteps = [10.0, 25.0, 50.0, 100.0, 250.0, 500.0, 1000.0];

  double _zoom;
  double _range;
  double _lat;
  double _lng;

  ZoneModel() {
    _zoom = Constants.DEFAULT_ZOOM;
    _range = rangeSteps[3];
    _lat = Constants.DEFAULT_POSITION.latitude;
    _lng = Constants.DEFAULT_POSITION.longitude;
  }

  double get zoom => _zoom;
  double get range => _range;
  double get lat => _lat;
  double get lng => _lng;

  void _setZoom(double value) {
    if(value >= Constants.MAX_ZOOM) {
      _zoom = Constants.MAX_ZOOM;
      return;
    }

    if(value <= Constants.MIN_ZOOM) {
      _zoom = Constants.MIN_ZOOM;
      return;
    }

    _zoom = value;
  }

  void _setRange(double value) {
    if(value >= Constants.MAX_RANGE) {
      _range = Constants.MAX_RANGE;
      return;
    }

    if(value <= Constants.MIN_RANGE) {
      _range = Constants.MIN_RANGE;
      return;
    }

    _range = value;
  }

  void _setLat(double value) {
    if(value >= Constants.MAX_LAT) {
      _lat = Constants.MAX_LAT;
      return;
    }

    if(value <= Constants.MIN_LAT) {
      _lat = Constants.MIN_LAT;
      return;
    }

    _lat = value;
  }

  void _setLng(double value) {
    if(value >= Constants.MAX_LNG) {
      _lng = Constants.MAX_LNG;
      return;
    }

    if(value <= Constants.MIN_LNG) {
      _lng = Constants.MIN_LNG;
      return;
    }

    _lng = value;
  }

  Future<void> positionCenter() async {
    var position = Constants.DEFAULT_POSITION;
    await GeolocationService.getCurrentPosition()
        .then((value) {
          position = value;
          print("Position set to: ${position}");
          _setLat(position.latitude);
          _setLng(position.longitude);
          notifyListeners();
        })
        .catchError((e) {
          print("Got error: ${e}");
        });
  }

  void positionTo(LatLng position) {
    _setLat(position.latitude);
    _setLng(position.longitude);
    print("Position set to ${_lat}, ${_lng}");
    notifyListeners();
  }

  void zoomTo(double value) {
    _setZoom(value);
    print("Zoom set to: ${_zoom}");
    notifyListeners();
  }

  void rangeTo(double value) {
    _setRange(value);
    print("Range set to:${_range}");
    notifyListeners();
  }

}