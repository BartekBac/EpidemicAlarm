import 'dart:convert';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BdlClient {
  Client _client;
  final String _baseUrl = Constants.BDL_API_BASE_URL + "units?format=json";

  BdlClient() {
    _client = http.Client();
  }

  List<RegionUnit> _parseRegionUnits(String responseBody) {
    dynamic parsed = jsonDecode(responseBody).cast<String, dynamic>();
    return parsed['results'].map<RegionUnit>((json) => RegionUnit.fromJson(json)).toList();
  }

  String _parseSubregionName(String name) {
    return name
        .replaceFirst("Powiat m. st. ", "")
        .replaceFirst("Powiat m.", "")
        .replaceFirst("Powiat ", "")
        .replaceFirst(" do 2002", "");
  }

  String _parseRegionName(String name) {
    return name.toLowerCase();
  }

  Future<List<RegionUnit>> getRegions() async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"&level=2&page-size=100")
      );
      List<RegionUnit> regionUnits = _parseRegionUnits(response.body);
      regionUnits.forEach((regionUnit) {
        regionUnit.name = _parseRegionName(regionUnit.name);
      });

      return regionUnits;
    } catch(e) {
      print("Cannot fetch regions from BDL API. Error: ${e.toString()}");
    }
  }

  Future<List<RegionUnit>> getSubregions(String parentRegionId) async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"&level=5&page-size=100&parent-id="+parentRegionId)
      );
      List<RegionUnit> regionUnits = _parseRegionUnits(response.body);
      regionUnits.forEach((regionUnit) {
        regionUnit.name = _parseSubregionName(regionUnit.name);
      });

      return regionUnits;
    } catch(e) {
      print("Cannot fetch subregions for [PARENT_REGION_ID="+parentRegionId+"] from BDL API. Error: ${e.toString()}");
    }
  }

  Future<List<RegionUnit>> getAllSubregions() async {
    try {
      List<RegionUnit> regionUnitsToReturn = <RegionUnit>[];
      for(int page = 0; page <= 4; page++) {
        var response = await _client.get(
            Uri.parse(
                _baseUrl + "&level=5&page-size=100&page=" + page.toString())
        );
        List<RegionUnit> regionUnits = _parseRegionUnits(response.body);
        regionUnits.forEach((regionUnit) {
          regionUnit.name = _parseSubregionName(regionUnit.name);
        });
        regionUnitsToReturn.addAll(regionUnits);
      }
      return regionUnitsToReturn;
    } catch(e) {
      print("Cannot fetch all subregions from BDL API. Error: ${e.toString()}");
    }
  }

  Future<List<RegionUnit>> getCities(String parentSubregionId) async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"&level=6&page-size=100&parent-id="+parentSubregionId)
      );
      List<RegionUnit> regionUnits = _parseRegionUnits(response.body);
      regionUnits.forEach((regionUnit) {
        regionUnit.name = _parseSubregionName(regionUnit.name);
      });

      return regionUnits;
    } catch(e) {
      print("Cannot fetch subregions for [PARENT_REGION_ID="+parentSubregionId+"] from BDL API. Error: ${e.toString()}");
    }
  }

}