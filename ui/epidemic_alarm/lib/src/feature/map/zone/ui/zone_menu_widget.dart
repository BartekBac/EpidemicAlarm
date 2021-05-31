import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneMenuWidget extends StatelessWidget {
  const ZoneMenuWidget({Key key, this.onCenterButtonClick}) : super(key: key);
  final VoidCallback onCenterButtonClick;

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneModel>(
    builder: (context, mapZone, child) => FloatingActionButton(
        child: Icon(Icons.remove),
          onPressed: () {
            mapZone.positionCenter()
                .then((value) => onCenterButtonClick());
          }
      )
    );
  }
}
