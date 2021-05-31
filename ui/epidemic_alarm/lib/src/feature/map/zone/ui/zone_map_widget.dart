import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:epidemic_alarm/src/feature/map/zone/controller/zone_marker_controller.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class ZoneMapWidget extends StatefulWidget {
  ZoneMapWidget({Key key}) : super(key: key);

  @override
  _ZoneMapWidgetState createState() => _ZoneMapWidgetState();
}

class _ZoneMapWidgetState extends State<ZoneMapWidget> {
  ZoneModel zone;
  MapController mapController;
  ZoneMarkerController zoneMarkerController;

  void updatePositionAndMarker() {
    mapController.move(LatLng(zone.lat, zone.lng), mapController.zoom);
    zoneMarkerController.updateCircleMarker(zone.lat, zone.lng, 4000);
  }

  @override
  void initState() {
    mapController = MapController();
    zoneMarkerController = ZoneMarkerController();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    zone = Provider.of<ZoneModel>(context, listen: true);
    /*zone.addListener(() => updatePositionAndMarker());*/
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
            FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    center: LatLng(zone.lat, zone.lng),
                    zoom: zone.zoom),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  CircleLayerOptions(circles: zoneMarkerController.circleMarkers)
                ]
            ),
            ZoneMenuWidget(
              onCenterButtonClick: () => updatePositionAndMarker()
            )
        ])
      ),
    );
  }

/*@override
  void dispose() {
    zone.removeListener(() => print("removed zone listener"));
    super.dispose();
  }*/
}
