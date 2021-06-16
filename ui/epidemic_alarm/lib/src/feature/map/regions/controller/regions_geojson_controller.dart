import 'package:epidemic_alarm/src/feature/map/regions/controller/low_resolution.dart';
import 'package:epidemic_alarm/src/feature/map/regions/controller/resolution_startegy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RegionsGeojsonController {

  ResolutionStartegy _resolution = new LowResolution();
  static List<Polygon> polygons = <Polygon>[];

  Future<void> parseAndDrawAssetsOnMap() async {
    final geo = GeoJson();
    geo.processedFeatures.listen((GeoJsonFeature feature) {
      print(feature.type.toString() + " => " + feature.properties.toString() + " ==> " + _resolution.getGeoPoints(feature.geometry).length.toString());
      polygons.add(
        Polygon(points:_resolution.getGeoPoints(feature.geometry).map((e) => LatLng(e.latitude, e.longitude)).toList(), color: Colors.greenAccent.withOpacity(0.2), borderColor: Colors.red, borderStrokeWidth: 1.0)
      );
    });
    /*geo.processedLines.listen((GeoJsonLine line) {
    /// when a line is parsed add it to the map right away
    setState(() => lines.add(Polyline(
        strokeWidth: 2.0, color: Colors.blue, points: line.geoSerie.toLatLng())));
  });*/
    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle
        .loadString(_resolution.getFileName());
    await geo.parse(data, verbose: true);
  }
}