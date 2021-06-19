import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/regions_low_resolution.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/resolution_startegy.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/subregions_low_resolution.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

class FencesMarkerController {

  final ResolutionStartegy _regionsResolution = new RegionsLowResolution();
  final ResolutionStartegy _subregionsResolution = new SubregionsLowResolution();
  final GeoJson _geo = GeoJson();
  static List<Polygon> polygons = <Polygon>[];
  static List<Marker> centroids = <Marker>[];

  List<Polygon> _regionsPolygons = <Polygon>[];
  List<Marker> _regionsCentroids = <Marker>[];
  List<Polygon> _subregionsPolygons = <Polygon>[];
  List<Marker> _subregionsCentroids = <Marker>[];

  LatLng _getCentroid(List<GeoPoint> geoPoints) {
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

  // TODO: here add methods such as addMarker or updateMarker which will set values of diagnoesdCases

  void showRegions() {
    polygons = _regionsPolygons;
    centroids = _regionsCentroids;
  }

  void showSubregions() {
    // TODO: cut it to specific region's subregions
    polygons = _subregionsPolygons;
    centroids = _subregionsCentroids;
  }

  Future<void> _renderPolygons(ResolutionStartegy resolution, polygons, centroids) async {
    _geo.processedFeatures.listen((GeoJsonFeature feature) {
      GeoSerie geoSerie = resolution.getGeoSerie(feature.geometry);
      LatLng centroid = _getCentroid(geoSerie.geoPoints);
      polygons.add(
          Polygon(
              points:geoSerie.toLatLng(),
              color: Colors.greenAccent.withOpacity(0.2),
              borderStrokeWidth: 1.0,
              borderColor: Colors.red)
      );
      centroids.add(
          Marker(
              point: centroid,
              builder: (ctx) =>
                  Container(child: FlutterLogo())
          )
      );
      //print(feature.type.toString() + " => " + feature.properties.toString() + " ==> " + geoSerie.geoPoints.length.toString() + " ===> " + centroid.toString());
    });

    _geo.endSignal.listen((_) => _geo.dispose());
    final data = await rootBundle.loadString(resolution.getFileName());
    await _geo.parse(data, verbose: true);
  }

  Future<void> renderSubregionsPolygons() async {
    _renderPolygons(_subregionsResolution, _subregionsPolygons, _subregionsCentroids);
  }

  Future<void> renderRegionsPolygons() async {
    _renderPolygons(_regionsResolution, _regionsPolygons, _regionsCentroids);
  }
}