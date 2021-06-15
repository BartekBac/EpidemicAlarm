import 'package:epidemic_alarm/src/feature/map/regions/controller/regions_geojson_controller.dart';
import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:epidemic_alarm/src/feature/map/zone/controller/zone_marker_controller.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_menu_widget.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class RegionsMapWidget extends StatefulWidget {
  RegionsMapWidget({Key key}) : super(key: key);

  @override
  _RegionsMapWidgetState createState() => _RegionsMapWidgetState();
}

class _RegionsMapWidgetState extends State<RegionsMapWidget> {
  MapController mapController;
  RegionsGeojsonController regionsGeojsonController;

  /*void centerPositionAndMarker() {
    mapController.moveAndRotate(LatLng(zone.lat, zone.lng), mapController.zoom, 0.0);
    updatePositionMarker();
  }*/


  @override
  void initState() {
    mapController = MapController();
    regionsGeojsonController = RegionsGeojsonController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: LatLng(Constants.DEFAULT_POSITION.latitude, Constants.DEFAULT_POSITION.longitude),
                  zoom: 8.0,
                  minZoom: Constants.MIN_ZOOM,
                  maxZoom: Constants.MAX_ZOOM
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']
                ),
                //CircleLayerOptions(circles: zoneMarkerController.circleMarkers)
                PolygonLayerOptions(polygons: RegionsGeojsonController.polygons)
              ],
            ),
            /*ZoneMenuWidget(
              onCenterButtonClick: () => centerPositionAndMarker(),
              onRangeDropdownChange: () => updateCursorRange(),
              onZoomChange: () => updateZoom(),
              onSearchButtonClick: () => updatePosition(),
            )*/
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
