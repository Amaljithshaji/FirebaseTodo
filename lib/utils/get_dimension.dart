import 'package:flutter/material.dart';

Dimensions getDimension(
    {required BuildContext context,
    double? horizontalPadding,
    double? verticalPadding}) {
  final double _horizontalPadding = horizontalPadding ?? 0;
  final double _verticalPadding = verticalPadding ?? 0;

  return Dimensions(
      h: MediaQuery.of(context).size.height - _verticalPadding,
      w: MediaQuery.of(context).size.width - _horizontalPadding);
}

class Dimensions {
  final double w;
  final double h;
  Dimensions({required this.h, required this.w});
}

double screenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}
double screenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}
