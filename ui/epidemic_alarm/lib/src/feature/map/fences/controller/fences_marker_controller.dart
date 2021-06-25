import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:flutter/material.dart';
import 'package:geojson/geojson.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

class FencesMarkerController {
  //final String _fileName = 'assets/polygons.geojson';

  static List<Polygon> polygons = <Polygon>[];
  static List<Marker> centroids = <Marker>[];

  /*List<FenceMarker> _fenceMarkers = <FenceMarker>[];

  List<FenceMarker> get fenceMarkers => _fenceMarkers;

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

  Future<void> init() async {
    await _fetchPolygons();
  }*/

  void showMarkers(List<FenceMarker> fenceMarkers) {
    polygons = fenceMarkers.map((fenceMarker) => fenceMarker.polygon).toList();
    centroids = fenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }

  /*void showRegions(List<FenceMarker> regions) {

    polygons = regions.map((fenceMarker) => fenceMarker.polygon).toList();
    centroids = _regionFenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }

  void showSubregions(List<RegionUnit> subregions) {
    List<FenceMarker> filteredSubregionFenceMarkers = _subregionFenceMarkers
        .where((fenceMarker) => subregions.any((subregion) => subregion.name == fenceMarker.name)).toList();
    filteredSubregionFenceMarkers.forEach((subregionMarker) {
      subregionMarker.diagnosedCasesCount = subregions.firstWhere((subregion) => subregion.name == subregionMarker.name).diagnosedCasesCount;
    });
    polygons = filteredSubregionFenceMarkers.map((fenceMarker) => fenceMarker.polygon).toList();
    print("Showed polygons: " + polygons.length.toString() + "/" + _subregionFenceMarkers.length.toString() + "/" + subregions.length.toString());
    centroids = filteredSubregionFenceMarkers.map((fenceMarker) => fenceMarker.centroidMarker).toList();
  }*/

  /*GeoSerie _getGeoSerie(dynamic geometry) {
    if(geometry is GeoJsonPolygon)
      return geometry.geoSeries.first;
    else
      return (geometry as GeoJsonMultiPolygon).polygons.first.geoSeries.first;
  }

  Future<void> _fetchPolygons() async {
    final GeoJson geo = GeoJson();
    geo.processedFeatures.listen((GeoJsonFeature feature) {
      GeoSerie geoSerie = _getGeoSerie(feature.geometry);
      LatLng centroid = _calculateCentroid(geoSerie.geoPoints);

      // TODO: bug: for some subregions are defined multipolygons etc "rybnicki" but shown is only one (and one centroid)

      FenceMarker fenceMarker = FenceMarker(
          id: feature.properties['id'],
          name: feature.properties['name'],
          parentId: feature.properties['bdlParentId'],
          parentName: feature.properties['bdlParentName'],
          level: feature.properties['level'],
          points: geoSerie.toLatLng(),
          centroid: centroid,
          diagnosedCasesCount: 0
      );
      _fenceMarkers.add(fenceMarker);
      //print(feature.type.toString() + " => " + feature.properties['name'].toString() + " ==> " + geoSerie.geoPoints.length.toString() + " ===> " + feature.properties['bdlParentId'].toString());
    });

    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle.loadString(_fileName);
    await geo.parse(data, verbose: true);
  }*/
}