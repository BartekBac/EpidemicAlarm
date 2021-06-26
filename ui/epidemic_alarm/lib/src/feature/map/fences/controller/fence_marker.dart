import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

class FenceMarker {
  int id;
  String name;
  String parentName;
  String parentId;
  int level;
  List<LatLng> centroids;
  List<GeoSerie> geoSeries;
  int diagnosedCasesCount;
  Marker get centroidMarker => Marker(
      point: centroids.first,
      builder: (ctx) =>
        Container(child: Text(diagnosedCasesCount.toString(), style: TextStyle(color: Colors.red, fontSize: 24),))
  );

  List<Polygon> get polygons {
    return geoSeries.map((geoSerie) => Polygon(
        points: geoSerie.toLatLng(),
        color: Colors.greenAccent.withOpacity(0.2),
        borderStrokeWidth: 1.0,
        borderColor: Colors.red
    )).toList();
  }

  List<Polyline> get polylines {
    List<Polyline> polylines = <Polyline>[];
    if(centroids.isNotEmpty && centroids.length > 1) {
      LatLng mainCentroid = centroids.first;
      centroids.skip(1).forEach((centroid) {
        polylines.add(Polyline(
            points: <LatLng>[mainCentroid, centroid],
            color: Colors.greenAccent.withOpacity(0.1),
            borderStrokeWidth: 1,
            borderColor: Colors.red,
            isDotted: true
        ));
      });
    }
    return polylines;
  }

  FenceMarker({this.id, this.name, this.parentName, this.parentId, this.level, this.geoSeries, this.centroids, this.diagnosedCasesCount});
}