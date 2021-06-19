import 'dart:convert';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/feature/map/fences/model/fence_entity.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BdlClient {
  Client _client;
  final String _baseUrl = Constants.BDL_API_BASE_URL + "units?format=json";

  BdlClient() {
    _client = http.Client();
  }

  List<Fence> _parseRegions(String responseBody) {
    dynamic parsed = jsonDecode(responseBody).cast<String, dynamic>();
    return parsed['results'].map<Fence>((json) => Fence.fromJson(json)).toList();
  }

  Future<List<Fence>> getRegions() async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"&level=2&page-size=100")
      );
      //List<RegionUnit> regionUnits = _parseRegions(response.body);
      List<Fence> toReturn = _parseRegions(response.body);//regionUnits.map((regionUnit) => Fence(id: regionUnit.id, name: regionUnit));
      print(toReturn);
      // return toReturn;
    } catch(e) {
      print("Cannot fetch diagnosed cases. Error: ${e.toString()}");
    }
  }
}