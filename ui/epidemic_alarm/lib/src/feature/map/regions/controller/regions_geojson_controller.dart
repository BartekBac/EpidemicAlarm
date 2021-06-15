import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RegionsGeojsonController {
  static List<Polygon> polygons = <Polygon>[];

  static Future<void> parseAndDrawAssetsOnMap() async {
    final geo = GeoJson();
    geo.processedFeatures.listen((GeoJsonFeature feature) {
      print(feature.type.toString() + " => " + feature.properties.toString() + " ==> " + (feature.geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first.geoPoints.length.toString());
      polygons.add(
        Polygon(points:(feature.geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first.geoPoints.map((e) => LatLng(e.latitude, e.longitude)).toList(), color: Colors.greenAccent.withOpacity(0.2), borderColor: Colors.greenAccent)
      );
    });
    /*geo.processedLines.listen((GeoJsonLine line) {
    /// when a line is parsed add it to the map right away
    setState(() => lines.add(Polyline(
        strokeWidth: 2.0, color: Colors.blue, points: line.geoSerie.toLatLng())));
  });*/
    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle
        .loadString('assets/wojewodztwa-max.geojson');
    await geo.parse(data, verbose: true);
  }
}