import 'package:epidemic_alarm/src/feature/main/controller/color_controller.dart';
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
        Text(diagnosedCasesCount.toString(), textWidthBasis: TextWidthBasis.longestLine, textAlign: TextAlign.center, softWrap: false, style: TextStyle(color: ColorController.getDangerTextColor(), fontSize: 18, fontWeight: FontWeight.bold))
  );

  List<Polygon> get polygons {
    return geoSeries.map((geoSerie) => Polygon(
        points: geoSerie.toLatLng(),
        color: ColorController.getDangerSecondaryColor(diagnosedCasesCount),
        borderStrokeWidth: 1.0,
        borderColor: ColorController.getDangerLineColor()
    )).toList();
  }

  List<Polyline> get polylines {
    List<Polyline> polylines = <Polyline>[];
    if(centroids.isNotEmpty && centroids.length > 1) {
      LatLng mainCentroid = centroids.first;
      centroids.skip(1).forEach((centroid) {
        polylines.add(Polyline(
            points: <LatLng>[mainCentroid, centroid],
            color: ColorController.getDangerLineColor(),
            strokeWidth: 2
        ));
      });
    }
    return polylines;
  }

  FenceMarker({this.id, this.name, this.parentName, this.parentId, this.level, this.geoSeries, this.centroids, this.diagnosedCasesCount});
}