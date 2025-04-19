import 'package:flutter/material.dart';

Color getColorTheme(int level) {
  switch (level) {
    case 0:
      return Colors.amber;
    case 1:
      return Colors.red;
    case 2: 
      return Colors.teal;
    case 3:
      return Colors.indigoAccent;
    case 4:
      return Colors.purple;
    default:
      return Colors.teal;
  }
}