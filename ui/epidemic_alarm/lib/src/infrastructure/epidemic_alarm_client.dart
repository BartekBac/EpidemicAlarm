import 'dart:convert';
import 'dart:typed_data';

import 'package:epidemic_alarm/src/dto/diagnosed_case_dto.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EpidemicAlarmClient {
  Client _client;
  final String _baseUrl = Constants.EPIDEMIC_ALARM_API_BASE_URL + "diagnosed_case/";

  EpidemicAlarmClient() {
    _client = http.Client();
  }

  List<DiagnosedCase> _parseDiagnosedCases(Uint8List responseBodyBytes) {
    //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final parsed = json.decode(utf8.decode(responseBodyBytes)).cast<Map<String, dynamic>>();
    return parsed.map<DiagnosedCase>((json) => DiagnosedCase.fromJson(json)).toList();
  }

  Future<List<DiagnosedCase>> getActiveDiagnosedCasesInRange(double lat, double lng, double range) async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"?lat="+lat.toString()+"&lng="+lng.toString()+"&range="+range.toString()),
          headers: {'Content-Type': 'application/json'}
      );
      var toReturn = _parseDiagnosedCases(response.bodyBytes);
      print(toReturn);
      return toReturn;
    } catch(e) {
      print("Cannot fetch diagnosed cases. Error: ${e.toString()}");
    }
  }

  Future<List<DiagnosedCase>> getAllActiveDiagnosedCases() async {
    try {
      var response = await _client.get(
          Uri.parse(_baseUrl+"?onlyActive=true"),
          headers: {'Content-Type': 'application/json'}
      );
      var toReturn = _parseDiagnosedCases(response.bodyBytes);
      print(toReturn);
      return toReturn;
    } catch(e) {
      print("Cannot fetch all active diagnosed cases. Error: ${e.toString()}");
    }
  }
}