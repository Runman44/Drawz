import 'dart:ui';

class Point {

  final Offset offset;

  Point(this.offset);

  toJson() {
    return { 'point': {'dx': "${offset.dx}", 'dy': "${offset.dy}"}, };
  }

  static fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Point(Offset(
        double.parse(json['point']['dx']),
        double.parse(json['point']['dy'])
    ));
  }

}