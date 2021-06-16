import 'package:epidemic_alarm/src/feature/map/regions/controller/regions_geojson_controller.dart';
import 'package:epidemic_alarm/src/feature/map/regions/model/regions_model.dart';
import 'package:epidemic_alarm/src/feature/map/regions/ui/regions_menu_widget.dart';
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
  RegionsModel regions;

  /*void centerPositionAndMarker() {
    mapController.moveAndRotate(LatLng(zone.lat, zone.lng), mapController.zoom, 0.0);
    updatePositionMarker();
  }*/

  void updateZoom() {
    mapController.move(mapController.center, regions.zoom);
  }


  @override
  void initState() {
    mapController = MapController();
    regionsGeojsonController = RegionsGeojsonController();
    regionsGeojsonController.parseAndDrawAssetsOnMap();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    regions = Provider.of<RegionsModel>(context, listen: true);
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
                  center: LatLng(Constants.DEFAULT_POSITION.latitude, Constants.DEFAULT_POSITION.longitude),
                  zoom: regions.zoom,
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
            RegionsMenuWidget(
              //onCenterButtonClick: () => centerPositionAndMarker(),
              //onRangeDropdownChange: () => updateCursorRange(),
              onZoomChange: () => updateZoom(),
              //onSearchButtonClick: () => updatePosition(),
            )
          ])
      ),
    );
  }

@override
  void dispose() {
    regions.removeListener(() => print("removed regions listener"));
    super.dispose();
  }
}
