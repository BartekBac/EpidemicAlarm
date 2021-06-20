import 'package:epidemic_alarm/src/dto/diagnosed_case_dto.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/infrastructure/bdl_api_client.dart';
import 'package:epidemic_alarm/src/infrastructure/epidemic_alarm_client.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';

class FencesModel extends ChangeNotifier {
  double _zoom;
  bool _regionsLoaded;

  List<DiagnosedCase> _diagnosedCases;
  List<RegionUnit> _regions;
  List<RegionUnit> _subregions;
  List<RegionUnit> _cities;

  RegionUnit _otherRegion;
  RegionUnit _otherSubregion;
  RegionUnit _otherCity;

  EpidemicAlarmClient _epidemicAlarmClient;
  BdlClient _bdlClient;

  FencesModel() {
    _zoom = 8.0;//Constants.DEFAULT_ZOOM;
    _regionsLoaded = false;
    _epidemicAlarmClient = new EpidemicAlarmClient();
    _bdlClient = new BdlClient();
    _regions = <RegionUnit>[];
    _subregions = <RegionUnit>[];
    _cities = <RegionUnit>[];
    _otherRegion = new RegionUnit(id: "0", name: "Other Region", diagnosedCasesCount: 0, parentId: "0");
    _otherSubregion = new RegionUnit(id: "0", name: "Other Subregion", diagnosedCasesCount: 0, parentId: "0");
    _otherCity = new RegionUnit(id: "0", name: "Other City", diagnosedCasesCount: 0, parentId: "0");
  }

  double get zoom => _zoom;
  bool get regionsLoaded => _regionsLoaded;

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


  void zoomTo(double value) {
    _setZoom(value);
    print("Zoom set to: ${_zoom}");
    notifyListeners();
  }

  Future<void> initFences() async {
    // fetch all data from servers
    await _fetchAllActiveDiagnosedCases();
    await _fetchRegions();
    await _fetchSubregions();

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
    this._regions.forEach((region) => print(region.name +" ["+ region.id.toString() + "]: " + region.diagnosedCasesCount.toString()));
    this._subregions.forEach((subregion) => print(subregion.name +" ["+ subregion.id.toString() + "]: " + subregion.diagnosedCasesCount.toString()));
    this._cities.forEach((city) => print(city.name +" ["+ city.id.toString() + ", parent: " + city.parentId + "]: " + city.diagnosedCasesCount.toString()));
    print("Other Region: " + _otherRegion.diagnosedCasesCount.toString());
    print("Other Subregion: " + _otherSubregion.diagnosedCasesCount.toString());
    print("Other City: " + _otherCity.diagnosedCasesCount.toString());
  }

  Future<void> _fetchAllActiveDiagnosedCases() async {
    this._diagnosedCases = await _epidemicAlarmClient.getAllActiveDiagnosedCases();
  }

  Future<void> _fetchRegions() async {
    this._regions = await _bdlClient.getRegions();
  }

  Future<void> _fetchSubregions() async {
    this._subregions = await _bdlClient.getAllSubregions();
    this._subregions.removeWhere((subregion) => subregion.name == "Wałbrzych od 2013");
  }

}