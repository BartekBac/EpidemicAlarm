import 'package:epidemic_alarm/src/app.dart';
import 'package:epidemic_alarm/src/feature/map/zone/model/map_zone_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
        create: (context) => MapZoneModel(),
        child: App(),
    )
  );
}