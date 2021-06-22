import 'package:epidemic_alarm/src/dto/diagnosed_case_dto.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/infrastructure/epidemic_alarm_client.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';

class FencesModel extends ChangeNotifier {
  EpidemicAlarmClient _epidemicAlarmClient = new EpidemicAlarmClient();

  static final List<String> SCOPES = <String>[];
  static final String GENERAL_SCOPE_NAME = "polska";

  double _zoom;
  String _activeScope;

  set activeScope(String value) {
    _activeScope = value;
  }

  List<DiagnosedCase> _diagnosedCases;
  List<RegionUnit> _regions;
  List<RegionUnit> _subregions;
  List<RegionUnit> _cities;

  RegionUnit _otherRegion;
  RegionUnit _otherSubregion;
  RegionUnit _otherCity;

  FencesModel() {
    _zoom = 8.0;//Constants.DEFAULT_ZOOM;
    _regions = <RegionUnit>[];
    _subregions = <RegionUnit>[];
    _cities = <RegionUnit>[];
    _otherRegion = new RegionUnit(id: "0", name: "Other Region", diagnosedCasesCount: 0, parentId: "0");
    _otherSubregion = new RegionUnit(id: "0", name: "Other Subregion", diagnosedCasesCount: 0, parentId: "0");
    _otherCity = new RegionUnit(id: "0", name: "Other City", diagnosedCasesCount: 0, parentId: "0");
  }

  double get zoom => _zoom;
  String get activeScope => _activeScope;
  List<RegionUnit> get regions => _regions;
  List<RegionUnit> get subregions => _subregions;
  List<RegionUnit> get cities => _cities;
  RegionUnit get otherRegion => _otherRegion;
  RegionUnit get otherSubregion => _otherSubregion;
  RegionUnit get otherCity => _otherCity;
  List<DiagnosedCase> get diagnosedCases => _diagnosedCases;

  List<RegionUnit> get activeScopeRegionUnits {
    if(_activeScope == GENERAL_SCOPE_NAME) {
      return _regions;
    } else {
      String parentRegionId = _regions.firstWhere((region) => region.name == _activeScope).id;
      return _subregions.where((subregion) => subregion.id.startsWith(parentRegionId.substring(0, 3))).toList();
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

  Future<void> _fetchAllActiveDiagnosedCases() async {
    this._diagnosedCases = await _epidemicAlarmClient.getAllActiveDiagnosedCases();
  }

  void setRegions(List<RegionUnit> regions) {
    this._regions = regions;
    SCOPES.clear();
    SCOPES.add(GENERAL_SCOPE_NAME);
    if(_regions.isNotEmpty) {
      _regions.forEach((region) => SCOPES.add(region.name));
    }
    _activeScope = SCOPES[0];
  }

  void setSubregions(List<RegionUnit> subregions) {
    this._subregions = subregions;
  }

  Future<void> updateSubregionsAndCitiesCounts() async {
    await _fetchAllActiveDiagnosedCases();
    _diagnosedCases.forEach((diagnosedCase) {
      RegionUnit subregionToUpdate = this._subregions.firstWhere((subregion) =>
      subregion.name == (diagnosedCase.subregion ?? _otherSubregion.name),
          orElse: () => _otherSubregion);
      RegionUnit cityToUpdate = this._cities.firstWhere((city) =>
      city.name == (diagnosedCase.city ?? _otherCity.name), orElse: () {
        if (diagnosedCase.city != null) {
          RegionUnit newCity = RegionUnit(
              id: this._cities.length.toString(),
              name: diagnosedCase.city,
              parentId: subregionToUpdate.id,
              diagnosedCasesCount: 0
          );
          this._cities.add(newCity);
          return newCity;
        } else {
          return _otherCity;
        }
      });

      subregionToUpdate.diagnosedCasesCount++;
      cityToUpdate.diagnosedCasesCount++;
    });
  }

  Future<void> updateRegionsCounts() async {
    await _fetchAllActiveDiagnosedCases();
    _diagnosedCases.forEach((diagnosedCase) {
      RegionUnit regionToUpdate = this._regions.firstWhere((region) => region.name == (diagnosedCase.region ?? _otherRegion.name), orElse: () => _otherRegion);
      regionToUpdate.diagnosedCasesCount++;
    });
  }

  Future<void> updateAllCounts() async {
    await _fetchAllActiveDiagnosedCases();
    // update in parallel region/subregion/city counters
    _diagnosedCases.forEach((diagnosedCase) {
      RegionUnit regionToUpdate = this._regions.firstWhere((region) => region.name == (diagnosedCase.region ?? _otherRegion.name), orElse: () => _otherRegion);
      RegionUnit subregionToUpdate = this._subregions.firstWhere((subregion) => subregion.name == (diagnosedCase.subregion ?? _otherSubregion.name), orElse: () => _otherSubregion);
      RegionUnit cityToUpdate = this._cities.firstWhere((city) => city.name == (diagnosedCase.city ?? _otherCity.name), orElse: () {
        if(diagnosedCase.city != null) {
          RegionUnit newCity = RegionUnit(
              id: this._cities.length.toString(),
              name: diagnosedCase.city,
              parentId: subregionToUpdate.id,
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