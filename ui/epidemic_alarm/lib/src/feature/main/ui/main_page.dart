import 'package:epidemic_alarm/src/feature/map/regions/ui/regions_map_widget.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_map_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String _appBarTitle = "Epidemic Alarm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        centerTitle: true,
      ),
      body: Center(
        child: RegionsMapWidget(),
      )
    );
  }
}

