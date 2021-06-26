import 'package:epidemic_alarm/src/feature/map/fences/controller/fences_marker_controller.dart';
import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:epidemic_alarm/src/feature/map/fences/ui/fences_menu_widget.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class FencesMapWidget extends StatefulWidget {
  FencesMapWidget({Key key}) : super(key: key);

  @override
  _FencesMapWidgetState createState() => _FencesMapWidgetState();
}

class _FencesMapWidgetState extends State<FencesMapWidget> {
  MapController mapController = MapController();

  /*void centerPositionAndMarker() {
    mapController.moveAndRotate(LatLng(zone.lat, zone.lng), mapController.zoom, 0.0);
    updatePositionMarker();
  }*/

  void updateZoom(double zoom) {
    mapController.move(mapController.center, zoom);
  }

  void updateDisplayedRegions(FencesModel fences) {
    FencesMarkerController.showMarkers(fences.activeScopeMarkers);
    mapController.move(mapController.center, fences.zoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<FencesModel>(
            builder: (context, fences, child) {
              return Stack(children: <Widget>[
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    center: LatLng(Constants.DEFAULT_POSITION.latitude, Constants.DEFAULT_POSITION.longitude),
                    zoom: fences.zoom,
                    minZoom: Constants.MIN_ZOOM,
                    maxZoom: Constants.MAX_ZOOM
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  PolygonLayerOptions(polygons: FencesMarkerController.polygons),
                  MarkerLayerOptions(markers: FencesMarkerController.centroids)
                ],
              ),
              FencesMenuWidget(
                onRegionDropdownChange: () => updateDisplayedRegions(fences),
                onZoomChange: () => updateZoom(fences.zoom),
              )
            ]);},
          )
      ),
    );
  }

}
