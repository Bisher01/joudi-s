import 'package:flutter/material.dart';

class WidgetSize {
  // It's the AdobeXD Device Height
  final double targetHeightSize = 926;
  // It's the AdobeXD Device Width
  final double targetWidthSize = 428;

  double getHeight(double targetWidgetHeight,BuildContext context) =>
      (MediaQuery.of(context).size.height * targetWidgetHeight) / targetHeightSize;

  double getWidth(double targetWidgetWidth,BuildContext context) =>
      (MediaQuery.of(context).size.width * targetWidgetWidth) / targetWidthSize;
}

final widgetSize = WidgetSize();
