import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class FenceMarker {
  int id;
  String name;
  String parentName;
  String parentId;
  int level;
  LatLng centroid;
  List<LatLng> points;
  int diagnosedCasesCount;
  Marker get centroidMarker => Marker(
      point: centroid,
      builder: (ctx) =>
        Container(child: Text(diagnosedCasesCount.toString(), style: TextStyle(color: Colors.red, fontSize: 24),))
  );
  Polygon get polygon => Polygon(
      points: points,
      color: Colors.greenAccent.withOpacity(0.2),
      borderStrokeWidth: 1.0,
      borderColor: Colors.red);

  FenceMarker({this.id, this.name, this.parentName, this.parentId, this.level, this.points, this.centroid, this.diagnosedCasesCount});
}