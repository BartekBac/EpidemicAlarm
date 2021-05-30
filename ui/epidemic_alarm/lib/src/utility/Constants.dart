import 'package:geolocator/geolocator.dart';

class Constants {

  static Position defaultPosition = Position(
      latitude: 50.292222,
      longitude: 18.6675,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0
  );

  static List<double> rangeSteps = [10.0, 25.0, 50.0, 100.0, 250.0, 500.0, 1000.0];



}