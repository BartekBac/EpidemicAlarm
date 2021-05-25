import 'package:epidemic_alarm/src/views/MapWidget.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  MainTabView({Key key}) : super(key: key);

  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MapWidget(),
      )
    );
  }
}