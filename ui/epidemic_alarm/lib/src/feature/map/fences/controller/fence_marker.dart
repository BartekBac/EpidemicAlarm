import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class FenceMarker {
  String name;
  Polygon polygon;
  LatLng centroid;
  int diagnosedCasesCount;
  Marker get centroidMarker => Marker(
      point: centroid,
      builder: (ctx) =>
        Container(child: Text(diagnosedCasesCount.toString(), style: TextStyle(color: Colors.red, fontSize: 24),))
  );

  FenceMarker({this.name, this.polygon, this.centroid, this.diagnosedCasesCount});
}