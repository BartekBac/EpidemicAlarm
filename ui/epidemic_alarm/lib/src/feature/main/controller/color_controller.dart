import 'package:flutter/material.dart';

class ColorController {

  static Color getDangerPrimaryColor(diagnosedCasesCount) {
    if(diagnosedCasesCount <= 0) {
      return Colors.green;
    }
    if(diagnosedCasesCount <= 10) {
      return Colors.yellow;
    }
    if(diagnosedCasesCount <= 100) {
      return Colors.orange;
    }
    return Colors.red;
  }

  static Color getDangerSecondaryColor(diagnosedCasesCount) {
    if(diagnosedCasesCount <= 0) {
      return Colors.green.withOpacity(0.3);
    }
    if(diagnosedCasesCount <= 1) {
      return Colors.yellow.withOpacity(0.3);
    }
    if(diagnosedCasesCount <= 10) {
      return Colors.yellow.withOpacity(0.6);
    }
    if(diagnosedCasesCount <= 50) {
      return Colors.orange.withOpacity(0.3);
    }
    if(diagnosedCasesCount <= 100) {
      return Colors.orange.withOpacity(0.6);
    }
    return Colors.red.withOpacity(0.4);
  }

  static Color getDangerTextColor() {
    return Colors.black87;
  }

  static Color getDangerLineColor() {
    return Colors.black45;
  }
}