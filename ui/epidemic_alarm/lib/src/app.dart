import 'package:epidemic_alarm/src/feature/main/ui/main_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  static const String _title = 'EpidemicAlarm';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: _title,
      theme: ThemeData.light(),
      routes: <String, WidgetBuilder>{
        '/': (context) => MainPage()
      },
    );
  }
}