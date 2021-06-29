import 'package:epidemic_alarm/src/feature/map/fences/model/fences_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FencesDropdownWidget extends StatelessWidget {
  const FencesDropdownWidget({this.onRegionDropdownChange});
  final VoidCallback onRegionDropdownChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<FencesModel>(
      builder: (context, fence, child) => Container(
        height: 40.0,
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
        child: DropdownButton<String>(
          dropdownColor: Colors.blue,

          value: fence.activeScope,
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
          underline: Container(
            height: 3,
            color: Colors.white,
          ),
          onChanged: (String newValue) {
            fence.activeScope = newValue;
            onRegionDropdownChange();
          },
          items: FencesModel.SCOPES.map<DropdownMenuItem<String>>(
                  (String value) {return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
