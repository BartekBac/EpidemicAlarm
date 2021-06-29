import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:epidemic_alarm/src/feature/map/fences/ui/fences_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FencesMenuWidget extends StatelessWidget {
  const FencesMenuWidget({Key key, this.onZoomChange, this.onRegionDropdownChange}) : super(key: key);
  final VoidCallback onZoomChange;
  final VoidCallback onRegionDropdownChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<FencesModel>(
    builder: (context, fences, child) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: FencesDropdownWidget(onRegionDropdownChange: () => onRegionDropdownChange()),
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
                        fences.zoomTo(fences.zoom + 1);
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
                        fences.zoomTo(fences.zoom - 1);
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
