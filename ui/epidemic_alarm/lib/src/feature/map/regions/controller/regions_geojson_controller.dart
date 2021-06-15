import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';

class RegionsGeojsonController {
  final lines = <Polyline>[];

  static Future<void> parseAndDrawAssetsOnMap() async {
    final geo = GeoJson();
    geo.processedFeatures.listen((GeoJsonFeature feature) {
      print(feature.type.toString() + " => " + feature.properties.toString() + " ==> " + (feature.geometry as GeoJsonMultiPolygon).polygons.length.toString());
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