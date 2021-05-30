import 'dart:async';

import 'package:epidemic_alarm/src/logic/GeolocationService.dart';
import 'package:epidemic_alarm/src/utility/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  Position _position = Constants.DEFAULT_POSITION;
  double _zoom = 11.0;

  var circleMarkers = <CircleMarker>[
    CircleMarker(
        point: LatLng(37.4219983, -122.084),
        color: Colors.blue.withOpacity(0.7),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: 2000 // 2000 meters | 2 km
    ),
  ];

  void _setCurrentUserPosition() async {
    var position = _position;
    await GeolocationService.getCurrentPosition()
        .then((value) => position = value)
        .catchError((e) {
      print("Got error: ${e}");
      return position;
    });
    setState(() {
      _position = position;
      print("Position set: ${position.toString()}");
    });
    await statefulMapController.centerOnPoint(LatLng(_position.latitude, _position.longitude));
  }

  @override
  void initState() {
    // intialize the controllers
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);

    // wait for the controller to be ready before using it
    statefulMapController.onReady.then((_) {
      print("The map controller is ready");
      _setCurrentUserPosition();
    });

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
            FlutterMap(
              mapController: mapController,
              options: MapOptions(center: LatLng(_position.latitude, _position.longitude), zoom: _zoom),
              layers: [
                statefulMapController.tileLayer,
                MarkerLayerOptions(markers: statefulMapController.markers),
                PolylineLayerOptions(polylines: statefulMapController.lines),
                PolygonLayerOptions(polygons: statefulMapController.polygons),
                CircleLayerOptions(circles: circleMarkers)
              ]
            ),
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                circleMarkers.add(
                  CircleMarker(
                      point: LatLng(37.4219983, -122.084),
                      color: Colors.blue.withOpacity(0.7),
                      borderStrokeWidth: 2,
                      useRadiusInMeter: true,
                      radius: 4000 // 2000 meters | 2 km
                  ),
                );
              });
              },
            ),
          ])),
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}