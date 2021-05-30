import 'package:epidemic_alarm/src/views/MapWidget.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  MainTabView({Key key}) : super(key: key);

  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {

  String _appBarTitle = "Epidemic Alarm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        centerTitle: true,
      ),
      body: Center(
        child: MapWidget(),
      )
    );
  }
}

