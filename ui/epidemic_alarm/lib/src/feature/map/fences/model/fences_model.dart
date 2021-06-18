import 'package:epidemic_alarm/src/infrastructure/epidemic_alarm_client.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';

class FencesModel extends ChangeNotifier {
  double _zoom;

  EpidemicAlarmClient _epidemicAlarmClient;

  FencesModel() {
    _zoom = 8.0;//Constants.DEFAULT_ZOOM;
    _epidemicAlarmClient = new EpidemicAlarmClient();
  }

  double get zoom => _zoom;

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


  void zoomTo(double value) {
    _setZoom(value);
    print("Zoom set to: ${_zoom}");
    notifyListeners();
  }

}