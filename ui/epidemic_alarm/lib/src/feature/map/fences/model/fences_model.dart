import 'package:epidemic_alarm/src/dto/diagnosed_case_dto.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/feature/map/fences/controller/fence_marker.dart';
import 'package:epidemic_alarm/src/infrastructure/epidemic_alarm_client.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/infrastructure/geojson_reader.dart';
import 'package:flutter/material.dart';

class FencesModel extends ChangeNotifier {
  EpidemicAlarmClient _epidemicAlarmClient = new EpidemicAlarmClient();
  GeojsonReader _geojsonReader = new GeojsonReader();

  static final List<String> SCOPES = <String>[];
  static final String GENERAL_SCOPE_NAME = "polska";

  double _zoom;
  String _activeScope;

  set activeScope(String value) {
    _activeScope = value;
  }

  List<DiagnosedCase> _diagnosedCases;
  List<FenceMarker> _regions;
  List<FenceMarker> _subregions;
  List<FenceMarker> _cities;

  FenceMarker _otherRegion;
  FenceMarker _otherSubregion;
  FenceMarker _otherCity;

  FencesModel() {
    _zoom = 8.0;//Constants.DEFAULT_ZOOM;
    _regions = <FenceMarker>[];
    _subregions = <FenceMarker>[];
    _cities = <FenceMarker>[];
    _otherRegion = new FenceMarker(id: 0, name: "Other Region", parentId: "0", parentName: null, level: 2, centroid: null, points: null, diagnosedCasesCount: 0);
    _otherSubregion = new FenceMarker(id: 0, name: "Other Subregion", parentId: "0", parentName: null, level: 5, centroid: null, points: null, diagnosedCasesCount: 0);
    _otherCity = new FenceMarker(id: 0, name: "Other City", parentId: "0", parentName: null, level: 6, centroid: null, points: null, diagnosedCasesCount: 0);
  }

  double get zoom => _zoom;
  String get activeScope => _activeScope;
  List<FenceMarker> get regions => _regions;
  List<FenceMarker> get subregions => _subregions;
  List<FenceMarker> get cities => _cities;
  FenceMarker get otherRegion => _otherRegion;
  FenceMarker get otherSubregion => _otherSubregion;
  FenceMarker get otherCity => _otherCity;
  List<DiagnosedCase> get diagnosedCases => _diagnosedCases;

  List<FenceMarker> get activeScopeMarkers {
    if(_activeScope == GENERAL_SCOPE_NAME) {
      return _regions;
    } else {
      return _subregions.where((subregion) => subregion.parentName == _activeScope).toList();
    }
  }

  void _setZoom(double value) {
    if(value >= Constants.MAX_ZOOM) {
      _zoom = Constants.MAX_ZOOM;
      return;
    }

    if(value <= Constants.MIN_ZOOM) {
      _zoom = Constants.MIN_ZOOM;
      return;
    }

    _zoom = value;
  }

  Future<void> _getAllActiveDiagnosedCases() async {
    this._diagnosedCases = await _epidemicAlarmClient.getAllActiveDiagnosedCases();
  }

  Future<void> init() async {
    List<FenceMarker> fenceMarkers = await _geojsonReader.getFenceMarkers();
    this._regions = fenceMarkers.where((fm) => fm.level == 2).toList();
    this._subregions = fenceMarkers.where((fm) => fm.level == 5).toList();
    SCOPES.clear();
    SCOPES.add(GENERAL_SCOPE_NAME);
    if(_regions.isNotEmpty) {
      _regions.forEach((region) => SCOPES.add(region.name));
    }
    _activeScope = SCOPES[0];
    await updateDiagnosedCaseCounts();
  }

  Future<void> updateDiagnosedCaseCounts() async {
    await _getAllActiveDiagnosedCases();
    // clear all counters
    _regions.forEach((region) => region.diagnosedCasesCount = 0);
    _subregions.forEach((subregion) => subregion.diagnosedCasesCount = 0);
    _cities.forEach((city) => city.diagnosedCasesCount = 0);
    // update in parallel region/subregion/city counters
    _diagnosedCases.forEach((diagnosedCase) {
      FenceMarker regionToUpdate = this._regions.firstWhere((region) => region.name == (diagnosedCase.region ?? _otherRegion.name), orElse: () => _otherRegion);
      FenceMarker subregionToUpdate = this._subregions.firstWhere((subregion) => subregion.name == (diagnosedCase.subregion ?? _otherSubregion.name), orElse: () => _otherSubregion);
      FenceMarker cityToUpdate = this._cities.firstWhere((city) => city.name == (diagnosedCase.city ?? _otherCity.name), orElse: () {
        if(diagnosedCase.city != null) {
          FenceMarker newCity = FenceMarker(
              id: this._cities.length,
              name: diagnosedCase.city,
              parentId: "", // TODO: change to bdlIds
              parentName: subregionToUpdate.parentName,
              points: null,
              centroid: null,
              level: 6,
              diagnosedCasesCount: 0
          );
          this._cities.add(newCity);
          return newCity;
        } else {
          return _otherCity;
        }
      });

      regionToUpdate.diagnosedCasesCount++;
      subregionToUpdate.diagnosedCasesCount++;
      cityToUpdate.diagnosedCasesCount++;
    });

    // print
    //this._regions.forEach((region) => print(region.name +" ["+ region.id.toString() + "]: " + region.diagnosedCasesCount.toString()));
    //this._subregions.forEach((subregion) => print(subregion.name +" ["+ subregion.id.toString() + "]: " + subregion.diagnosedCasesCount.toString()));
    //this._cities.forEach((city) => print(city.name +" ["+ city.id.toString() + ", parent: " + city.parentId + "]: " + city.diagnosedCasesCount.toString()));
    //print("Other Region: " + _otherRegion.diagnosedCasesCount.toString());
    //print("Other Subregion: " + _otherSubregion.diagnosedCasesCount.toString());
    //print("Other City: " + _otherCity.diagnosedCasesCount.toString());
  }

  void zoomTo(double value) {
    _setZoom(value);
    print("Zoom set to: ${_zoom}");
    notifyListeners();
  }
}