import 'package:epidemic_alarm/src/logic/GeolocationService.dart';
import 'package:epidemic_alarm/src/utility/configuration.dart';
import 'package:flutter/material.dart';

class MapZoneModel extends ChangeNotifier {
  static final List<double> rangeSteps = [10.0, 25.0, 50.0, 100.0, 250.0, 500.0, 1000.0];

  double _zoom;
  int _rangeIndex;
  double _lat;
  double _lng;

  MapZoneModel() {
    _zoom = 11.0;
    _rangeIndex = 3;
    _lat = Constants.DEFAULT_POSITION.latitude;
    _lng = Constants.DEFAULT_POSITION.longitude;
  }

  double get zoom => _zoom;
  int get rangeIndex => _rangeIndex;
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

  void _setRangeIndex(int value) {
    if(value >= rangeSteps.length) {
      _rangeIndex = rangeSteps.length - 1;
      return;
    }

    if(value <= 0) {
      _rangeIndex = 0;
      return;
    }

    _rangeIndex = value;
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

  void positionCenter() {
    var position = Constants.DEFAULT_POSITION;
    GeolocationService.getCurrentPosition()
        .then((value) => position = value)
        .catchError((e) {
          print("Got error: ${e}");
        });
    _setLat(position.latitude);
    _setLng(position.longitude);
    notifyListeners();
  }

  void positionTo(double latitude, double longitude) {
    _setLat(latitude);
    _setLng(longitude);
    notifyListeners();
  }

  void zoomIn() {
    _setZoom(_zoom - 1);
    notifyListeners();
  }

  void zoomOut() {
    _setZoom(_zoom + 1);
    notifyListeners();
  }

  void rangeTo(int value) {
    _setRangeIndex(value);
    notifyListeners();
  }

}