import 'package:geolocator/geolocator.dart';

class Constants {

  static final String EPIDEMIC_ALARM_API_BASE_URL = "http://10.0.2.2:8080/api/rest/";

  static final Position DEFAULT_POSITION = Position(
      latitude: 50.292222,
      longitude: 18.6675
  );
  static final DEFAULT_ZOOM = 15.0;

  static final double MAX_ZOOM = 18.0;
  static final double MIN_ZOOM = 3.0;
  static final double MIN_LAT = -90.0;
  static final double MAX_LAT = 90.0;
  static final double MIN_LNG = -180.0;
  static final double MAX_LNG = 180.0;
  static final double MIN_RANGE = 1.0; // meters
  static final double MAX_RANGE = 100000; // meters

}