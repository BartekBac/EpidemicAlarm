import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:flutter_map/flutter_map.dart';

class FencesMarkerController {

  static List<Polygon> polygons = <Polygon>[];
  static List<Marker> centroids = <Marker>[];

  static void showMarkers(List<FenceMarker> fenceMarkers) {
    polygons = fenceMarkers.map((fenceMarker) => fenceMarker.polygon).toList();
    centroids = fenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }
}