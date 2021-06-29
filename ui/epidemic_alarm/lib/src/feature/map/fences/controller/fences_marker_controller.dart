import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:flutter_map/flutter_map.dart';

class FencesMarkerController {

  static List<Polygon> polygons = <Polygon>[];
  static List<Marker> centroids = <Marker>[];
  static List<Polyline> polylines = <Polyline>[];

  static void showMarkers(List<FenceMarker> fenceMarkers) {
    polygons.clear();
    polylines.clear();
    fenceMarkers.forEach((fenceMarker) {
      polygons.addAll(fenceMarker.polygons);
      polylines.addAll(fenceMarker.polylines);
    });
    centroids = fenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }
}