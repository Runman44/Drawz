import 'dart:ui';

import 'package:geo_artz/domain/model/point.dart';

class DrawingArea {
  Point? point;
  Paint? areaPaint;

  DrawingArea(this.point, this.areaPaint);
}