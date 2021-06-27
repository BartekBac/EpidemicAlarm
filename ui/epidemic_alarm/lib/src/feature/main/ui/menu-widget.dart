import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:epidemic_alarm/src/feature/map/fences/ui/fences_map_widget.dart';
import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with TickerProviderStateMixin {
  static final String _APP_BAR_TITE = "Epidemic Alarm";
  TabController _tabController;
  FencesModel _fencesModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fencesModel = FencesModel();
    _fencesModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_APP_BAR_TITE),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ZoneModel()),
          ChangeNotifierProvider(create: (context) => _fencesModel)],
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            Center(
              child: ZoneMapWidget()
            ),
            Center(
              child: FencesMapWidget()
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
