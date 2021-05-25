import 'package:epidemic_alarm/src/views/MainTabView.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  static const String _title = 'EpidemicAlarm';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: _title,
      theme: ThemeData.light(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
            centerTitle: true,
          ),
          body: MainTabView()),
    );
  }
}