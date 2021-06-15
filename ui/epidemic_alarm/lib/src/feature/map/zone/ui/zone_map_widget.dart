import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:epidemic_alarm/src/feature/map/zone/controller/zone_marker_controller.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_menu_widget.dart';
import 'package:epidemic_alarm/src/configuration.dart';
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

  void centerPositionAndMarker() {
    mapController.moveAndRotate(LatLng(zone.lat, zone.lng), mapController.zoom, 0.0);
    updatePositionMarker();
  }

  void updatePositionMarker() {
    zoneMarkerController.updateCircleMarker(zone.lat, zone.lng, zone.range, zone.secondaryColor, zone.primaryColor);
  }

  void updateCursorRange() {
    zoneMarkerController.updateCursorMarker(mapController.center.latitude, mapController.center.longitude, zone.range);
  }

  void updatePosition() {
    zone.positionTo(mapController.center)
        .then((value) => updatePositionMarker()
    );
  }

  void updateZoom() {
    mapController.move(mapController.center, zone.zoom);
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
                    zoom: zone.zoom,
                    minZoom: Constants.MIN_ZOOM,
                    maxZoom: Constants.MAX_ZOOM,
                    onPositionChanged: (position, flag) => zoneMarkerController.updateCursorMarker(position.center.latitude, position.center.longitude, zone.range)
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  CircleLayerOptions(circles: zoneMarkerController.circleMarkers)
                ],
            ),
            ZoneMenuWidget(
              onCenterButtonClick: () => centerPositionAndMarker(),
              onRangeDropdownChange: () => updateCursorRange(),
              onZoomChange: () => updateZoom(),
              onSearchButtonClick: () => updatePosition(),
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
