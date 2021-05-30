import 'package:epidemic_alarm/src/utility/configuration.dart';

class MapZoneModel {
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

  set zoom(double value) {
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

  set rangeIndex(int value) {
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

  set lat(double value) {
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

  set lng(double value) {
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
    lat = Constants.DEFAULT_POSITION.latitude;
    lng = Constants.DEFAULT_POSITION.longitude;
  }

  void positionTo(double latitude, double longitude) {
    lat = latitude;
    lng = longitude;
  }

  void zoomIn() {
    zoom -= 1;
  }

  void zoomOut() {
    zoom += 1;
  }

  void rangeTo(int value) {
    rangeIndex = value;
  }

}