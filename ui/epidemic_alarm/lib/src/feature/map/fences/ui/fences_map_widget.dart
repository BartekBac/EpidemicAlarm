import 'package:epidemic_alarm/src/feature/map/fences/controller/fences_marker_controller.dart';
import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:epidemic_alarm/src/feature/map/fences/ui/fences_menu_widget.dart';
import 'package:epidemic_alarm/src/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class FencesMapWidget extends StatefulWidget {
  FencesMapWidget({Key key}) : super(key: key);

  @override
  _FencesMapWidgetState createState() => _FencesMapWidgetState();
}

class _FencesMapWidgetState extends State<FencesMapWidget> {
  MapController mapController = MapController();

  void updateZoom(double zoom) {
    mapController.move(mapController.center, zoom);
  }

  void updateDisplayedRegions(FencesModel fences) {
    FencesMarkerController.showMarkers(fences.activeScopeMarkers);
    mapController.move(fences.activeScopeCenter, fences.activeScopeZoom);
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
                    center: FencesModel.GENERAL_SCOPE_CENTROID,
                    zoom: FencesModel.GENERAL_SCOPE_ZOOM,
                    minZoom: Constants.MIN_ZOOM,
                    maxZoom: Constants.MAX_ZOOM
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  PolygonLayerOptions(polygons: FencesMarkerController.polygons),
                  PolylineLayerOptions(polylines: FencesMarkerController.polylines),
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
