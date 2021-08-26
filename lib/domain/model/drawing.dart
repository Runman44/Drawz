import 'dart:typed_data';

import 'package:geo_artz/domain/model/point.dart';

class Drawing {
  final int? id;
  final String name;
   List<Point?> points;
   ByteData? imageBytes;

  Drawing(this.name, this.points, this.imageBytes, [this.id]);
}