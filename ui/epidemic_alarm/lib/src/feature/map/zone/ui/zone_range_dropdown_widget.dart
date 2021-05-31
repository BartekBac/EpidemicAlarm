import 'package:epidemic_alarm/src/feature/map/zone/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneRangeDropdownWidget extends StatelessWidget {
  const ZoneRangeDropdownWidget({this.onRangeDropdownChange});
  final VoidCallback onRangeDropdownChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneModel>(
      builder: (context, zone, child) => Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 0,
              offset: Offset(1, 1)
            )],
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        child: DropdownButton<double>(
          dropdownColor: Colors.blue,

          value: zone.range,
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
          underline: Container(
            height: 3,
            color: Colors.white,
          ),
          onChanged: (double newValue) {
            zone.rangeTo(newValue);
            onRangeDropdownChange();
          },
          items: ZoneModel.rangeSteps.map<DropdownMenuItem<double>>(
                  (double value) {return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.ceil().toString() + " m"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
