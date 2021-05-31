import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:epidemic_alarm/src/feature/map/zone/ui/zone_range_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneMenuWidget extends StatelessWidget {
  const ZoneMenuWidget({Key key, this.onCenterButtonClick, this.onRangeDropdownChange, this.onZoomChange, this.onSearchButtonClick}) : super(key: key);
  final VoidCallback onCenterButtonClick;
  final VoidCallback onSearchButtonClick;
  final VoidCallback onRangeDropdownChange;
  final VoidCallback onZoomChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneModel>(
    builder: (context, mapZone, child) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: ZoneRangeDropdownWidget(onRangeDropdownChange: () => onRangeDropdownChange()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      mini: true,
                      shape: RoundedRectangleBorder(),
                      onPressed: () {
                        mapZone.zoomTo(mapZone.zoom + 1);
                        onZoomChange();
                      }
                  ),
                  Container(
                    width: 1,
                    height: 1,
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.remove),
                      mini: true,
                      shape: RoundedRectangleBorder(),
                      onPressed: () {
                        mapZone.zoomTo(mapZone.zoom - 1);
                        onZoomChange();
                      }
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  FloatingActionButton(
                      child: Icon(Icons.search),
                      onPressed: () => mapZone.positionCenter().then((value) => onSearchButtonClick())
                  ),
                  Container(
                    width: 4,
                    height: 1,
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.my_location),
                      onPressed: () => mapZone.positionCenter().then((value) => onCenterButtonClick())
                  ),
                ],
              ),
            ),
          ]),
        )
    );
  }
}
