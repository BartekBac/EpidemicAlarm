import 'package:epidemic_alarm/src/feature/map/regions/model/regions_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegionsMenuWidget extends StatelessWidget {
  const RegionsMenuWidget({Key key, this.onZoomChange}) : super(key: key);
  final VoidCallback onZoomChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<RegionsModel>(
    builder: (context, regions, child) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      mini: true,
                      shape: RoundedRectangleBorder(),
                      onPressed: () {
                        regions.zoomTo(regions.zoom + 1);
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
                        regions.zoomTo(regions.zoom - 1);
                        onZoomChange();
                      }
                  ),
                ],
              ),
            ),
          ]),
        )
    );
  }
}
