import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/regions_low_resolution.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/resolution_startegy.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/adapters/subregions_low_resolution.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

class FencesMarkerController {

  final ResolutionStartegy _regionsResolution = new RegionsLowResolution();
  final ResolutionStartegy _subregionsResolution = new SubregionsLowResolution();
  static List<Polygon> polygons = <Polygon>[];
  static List<Marker> centroids = <Marker>[];

  List<FenceMarker> _regionFenceMarkers = <FenceMarker>[];
  List<FenceMarker> _subregionFenceMarkers = <FenceMarker>[];

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

  // TODO: here add methods such as addMarker or updateMarker which will set values of diagnosedCases

  Future<void> init() async {
    await _fetchRegionsPolygons();
    await _fetchSubregionsPolygons();
  }

  void showRegions(List<RegionUnit> regions) {
    _regionFenceMarkers.forEach((regionMarker) {
      regionMarker.diagnosedCasesCount = regions.firstWhere((region) => region.name == regionMarker.name).diagnosedCasesCount;
    });
    polygons = _regionFenceMarkers.map((fenceMarker) => fenceMarker.polygon).toList();
    print("Showed polygons: " + polygons.length.toString());
    centroids = _regionFenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }

  void showSubregions(List<String> subregionNames) {
    // TODO: cut it to specific region's subregions
    //polygons = _subregionsPolygons.where((subregion) => subregionNames.any((subregionName) => subregionName == subregion.));
    List<FenceMarker> filteredSubregionFenceMarkers = _subregionFenceMarkers
        .where((fenceMarker) => subregionNames.any((subregionName) => subregionName == fenceMarker.name));
    polygons = filteredSubregionFenceMarkers.map((fenceMarker) => fenceMarker.polygon).toList();
    centroids = filteredSubregionFenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }

  Future<void> _fetchPolygons(ResolutionStartegy resolution, List<FenceMarker> fenceMarkers) async {
    final GeoJson geo = GeoJson();
    geo.processedFeatures.listen((GeoJsonFeature feature) {
      GeoSerie geoSerie = resolution.getGeoSerie(feature.geometry);
      LatLng centroid = _calculateCentroid(geoSerie.geoPoints);

      Polygon polygon = Polygon(
          points:geoSerie.toLatLng(),
          color: Colors.greenAccent.withOpacity(0.2),
          borderStrokeWidth: 1.0,
          borderColor: Colors.red);

      FenceMarker fenceMarker = FenceMarker(
        name: feature.properties['nazwa'],
        polygon: polygon,
        centroid: centroid,
        diagnosedCasesCount: 0
      );
      fenceMarkers.add(fenceMarker);
      print(feature.type.toString() + " => " + feature.properties['nazwa'].toString() + " ==> " + geoSerie.geoPoints.length.toString() + " ===> " + centroid.toString());
    });

    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle.loadString(resolution.getFileName());
    await geo.parse(data, verbose: true);
  }

  Future<void> _fetchSubregionsPolygons() async {
    await _fetchPolygons(_subregionsResolution, _subregionFenceMarkers);
  }

  Future<void> _fetchRegionsPolygons() async {
    await _fetchPolygons(_regionsResolution, _regionFenceMarkers);
  }
}