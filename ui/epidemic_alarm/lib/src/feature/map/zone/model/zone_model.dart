import 'package:epidemic_alarm/src/feature/main/controller/color_controller.dart';
import 'package:epidemic_alarm/src/infrastructure/epidemic_alarm_client.dart';
import 'package:epidemic_alarm/src/infrastructure/geolocator_client.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class ZoneModel extends ChangeNotifier {
  static final List<double> rangeSteps = [10.0, 25.0, 50.0, 100.0, 250.0, 500.0, 1000.0];

  double _zoom;
  double _range;
  double _lat;
  double _lng;
  int _diagnosedCasesCount;


  EpidemicAlarmClient _epidemicAlarmClient;

  ZoneModel() {
    _zoom = Constants.DEFAULT_ZOOM;
    _range = rangeSteps[3];
    _lat = Constants.DEFAULT_POSITION.latitude;
    _lng = Constants.DEFAULT_POSITION.longitude;
    _epidemicAlarmClient = new EpidemicAlarmClient();
    _diagnosedCasesCount = -1;
  }

  double get zoom => _zoom;
  double get range => _range;
  double get lat => _lat;
  double get lng => _lng;
  Color get primaryColor => ColorController.getDangerPrimaryColor(_diagnosedCasesCount);
  Color get secondaryColor => ColorController.getDangerSecondaryColor(_diagnosedCasesCount);

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
    await GeolocatorClient.getCurrentPosition()
        .then((value) {
          positionTo(LatLng(value.latitude, value.longitude));
        })
        .catchError((e) {
          print("Got error: ${e}");
        });
  }

  Future<void> positionTo(LatLng position) async {
    _setLat(position.latitude);
    _setLng(position.longitude);
    await _epidemicAlarmClient.getActiveDiagnosedCasesInRange(position.latitude, position.longitude, _range)
        .then((value) {
          _diagnosedCasesCount = value.length;
          print("Found ${_diagnosedCasesCount} diagnosed cases in range ${_range}");
          notifyListeners();
    });
    print("Position set to ${_lat}, ${_lng}");
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