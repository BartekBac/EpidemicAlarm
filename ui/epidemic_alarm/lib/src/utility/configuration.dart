import 'package:geolocator/geolocator.dart';

class Constants {

  static final Position DEFAULT_POSITION = Position(
      latitude: 50.292222,
      longitude: 18.6675,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0
  );

  static final double MAX_ZOOM = 20.0;
  static final double MIN_ZOOM = 3.0;
  static final double MIN_LAT = -90.0;
  static final double MAX_LAT = 90.0;
  static final double MIN_LNG = -180.0;
  static final double MAX_LNG = 180.0;

}