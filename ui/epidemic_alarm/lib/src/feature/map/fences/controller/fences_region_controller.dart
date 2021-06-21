import 'package:epidemic_alarm/src/dto/region_unit_dto.dart';
import 'package:epidemic_alarm/src/infrastructure/bdl_api_client.dart';

class FencesRegionController {
  BdlClient _bdlClient = new BdlClient();

  List<RegionUnit> _regions;
  List<RegionUnit> _subregions;
  List<RegionUnit> _cities;

  List<RegionUnit> get regions => _regions;
  List<RegionUnit> get subregions => _subregions;
  List<RegionUnit> get cities => _cities;


  Future<List<RegionUnit>> getRegions() async {
    return _bdlClient.getRegions();
  }

  Future<List<RegionUnit>> getSubregions() async {
    List<RegionUnit> subregions = await _bdlClient.getAllSubregions();
    subregions.removeWhere((subregion) => subregion.name == "Wałbrzych od 2013");
    return subregions;
  }
}