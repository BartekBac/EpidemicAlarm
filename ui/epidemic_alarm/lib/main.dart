import 'package:epidemic_alarm/src/app.dart';
import 'package:epidemic_alarm/src/feature/map/regions/controller/regions_geojson_controller.dart';
import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  RegionsGeojsonController.parseAndDrawAssetsOnMap();

  runApp(
    ChangeNotifierProvider(
        create: (context) => ZoneModel(),
        child: App(),
    )
  );
}