import 'package:epidemic_alarm/src/feature/main/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/map/regions/model/regions_model.dart';
import 'feature/map/zone/model/zone_model.dart';

class App extends StatelessWidget {
  static const String _title = 'EpidemicAlarm';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: _title,
      theme: ThemeData.light(),
      routes: <String, WidgetBuilder>{
        '/': (context) => ChangeNotifierProvider(
            create: (context) => RegionsModel(),
            child: MainPage()
        ),
        '/xd': (context) => ChangeNotifierProvider(
          create: (context) => ZoneModel(),
          child: MainPage()
        )
      },
    );
  }
}