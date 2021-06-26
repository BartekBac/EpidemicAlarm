import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

import '../configuration.dart';

class GeojsonReader {
  final String _fileName = 'assets/polygons.geojson';
  List<FenceMarker> fenceMarkers = <FenceMarker>[];

  LatLng _calculateCentroid(List<GeoPoint> geoPoints) {
    double xMin = Constants.MAX_LNG;
    double xMax = Constants.MIN_LNG;
    double yMin = Constants.MAX_LAT;
    double yMax = Constants.MIN_LAT;
    if(geoPoints.isNotEmpty) {
      xMin = geoPoints.first.longitude;
      xMax = geoPoints.first.longitude;
      yMin = geoPoints.first.latitude;
      yMax = geoPoints.first.latitude;
      geoPoints.forEach((gp) {
        if (gp.latitude < yMin) yMin = gp.latitude;
        else if(gp.latitude > yMax) yMax = gp.latitude;
        if (gp.longitude < xMin) xMin = gp.longitude;
        else if(gp.longitude > xMax) xMax = gp.longitude;
      });
    }

    double lat = yMin + (yMax - yMin) / 2.0;
    double lng = xMin + (xMax - xMin) / 2.0;

    return LatLng(lat, lng);
  }

  List<GeoSerie> _getGeoSeries(dynamic geometry) {
    if(geometry is GeoJsonPolygon)
      return <GeoSerie>[geometry.geoSeries.first];
    else
      return (geometry as GeoJsonMultiPolygon).polygons.map((polygon) => polygon.geoSeries.first).toList();
  }

  Future<List<FenceMarker>> getFenceMarkers() async {
    if(fenceMarkers.isEmpty) {
      return _loadFenceMarkers();
    } else {
      return fenceMarkers;
    }
  }

  Future<List<FenceMarker>> _loadFenceMarkers() async {

    final GeoJson geo = GeoJson();

    geo.processedFeatures.listen((GeoJsonFeature feature) {
      List<GeoSerie> geoSeries = _getGeoSeries(feature.geometry);
      List<LatLng> centroids = geoSeries.map((geoSerie) => _calculateCentroid(geoSerie.geoPoints)).toList();

      FenceMarker fenceMarker = FenceMarker(
          id: feature.properties['id'],
          name: feature.properties['name'],
          parentId: feature.properties['bdlParentId'],
          parentName: feature.properties['bdlParentName'],
          level: feature.properties['level'],
          geoSeries: geoSeries,
          centroids: centroids,
          diagnosedCasesCount: 0
      );
      fenceMarkers.add(fenceMarker);
      //print(feature.type.toString() + " => " + feature.properties['name'].toString() + " ==> " + geoSerie.geoPoints.length.toString() + " ===> " + feature.properties['bdlParentId'].toString());
    });

    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle.loadString(_fileName);
    await geo.parse(data, verbose: true);

    return fenceMarkers;
  }
}