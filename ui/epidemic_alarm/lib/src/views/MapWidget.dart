import 'package:epidemic_alarm/src/logic/GeolocationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  double _zoom = 5.0;
  Position _currentPosition = Position(
      latitude: 51.5,
      longitude: -0.09,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0
  );

  MapOptions _mapOptions;

  void _setCurrentPosition() async {
    var position = _currentPosition;
    await GeolocationService.getCurrentPosition()
        .then((value) => position = value)
        .catchError((e) {
      print("Got error: ${e}");
      return _currentPosition;
    });
    setState(() {
      _currentPosition = position;
      print("Position set: ${position.toString()}");
    });
  }

  @override
  void initState() {
    _setCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 5.0,
      ),
      layers: [
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayerWidget(options: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        )),
        MarkerLayerWidget(options: MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
            ),
          ],
        )),
      ],
    );
  }
}