import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:geo_artz/data/database.dart';
import 'package:geo_artz/data/design_data_source_database.dart';
import 'package:geo_artz/data/design_repository.dart';
import 'package:geo_artz/domain/model/drawing.dart';
import 'package:geo_artz/domain/model/drawing_area.dart';
import 'package:geo_artz/domain/model/point.dart';
import 'package:geo_artz/domain/usecase/store_design.dart';
import 'package:geo_artz/domain/usecase/update_design.dart';
import 'package:get_it/get_it.dart';

class DrawScreen extends StatefulWidget {
  final Drawing? drawing;

  DrawScreen({this.drawing});

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  var points = <DrawingArea>[];
  double strokeWidth = 5.0;

  Future<ui.Image> saveToImage(List<DrawingArea> points) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    DrawingPainter painter = DrawingPainter(points);
    var size = context.size;
    painter.paint(canvas, size!);
    final picture = recorder.endRecording();
    return picture.toImage(size.width.floor(), size.height.floor());
  }

  @override
  void initState() {
    final widgetPoints = widget.drawing;
    if (widgetPoints != null) {
      this.points = widgetPoints.points.map((e) => DrawingArea(e,  Paint()
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..color = Colors.black
        ..strokeWidth = strokeWidth)).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          getDesignName(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple,
                      Colors.purple,
                    ])),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState(() {
                          points.add(DrawingArea(Point(details.localPosition),  Paint()
                            ..strokeCap = StrokeCap.round
                            ..isAntiAlias = true
                            ..color =  Colors.black
                            ..strokeWidth = strokeWidth));
                        });
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          print(details.localPosition.dx.toString() + " " + details.localPosition.dy.toString());
                          points.add(DrawingArea(Point(details.localPosition),  Paint()
                            ..strokeCap = StrokeCap.round
                            ..isAntiAlias = true
                            ..color =  Colors.black
                            ..strokeWidth = strokeWidth));
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          points.add(DrawingArea(null, null));
                        });
                      },
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: CustomPaint(
                            painter: DrawingPainter(points),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.brush,
                            color:  Colors.black,
                          ),
                          onPressed: () {
                            // selectColor();
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.linear_scale,
                            color:  Colors.black,
                          ),
                          onPressed: () {
                            // selectColor();
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.undo,
                            color:  Colors.black,
                          ),
                          onPressed: () {
                            // selectColor();
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.layers_clear,
                            color:  Colors.black,
                          ),
                          onPressed: () {
                            points.clear();
                          }),
                      // Expanded(
                      //   child: Slider(
                      //     min: 1.0,
                      //     max: 10.0,
                      //     label: "Stroke $strokeWidth",
                      //     activeColor:  Colors.black,
                      //     value: strokeWidth,
                      //     onChanged: (double value) {
                      //       this.setState(() {
                      //         strokeWidth = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                      IconButton(
                          icon: Icon(
                            Icons.done,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            this.setState((){
                              saveToImage(points).then((value) => value
                                  .toByteData(format: ui.ImageByteFormat.png)
                                  .then((value) => storeDrawing(value)));

                            });
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDesignName() {
    return widget.drawing != null ? widget.drawing!.name : "New design";
  }

  storeDrawing(ByteData? value) {
    var drawing = widget.drawing;
    if (drawing != null) {
      drawing.points = points.map((e) => e.point).toList();
      drawing.imageBytes = value;
      UpdateDesign(DesignRepository(
              DesignDataSourceDatabase(GetIt.instance<MyDatabase>())))
          .execute(drawing);
    } else {
      StoreDesign(DesignRepository(
              DesignDataSourceDatabase(GetIt.instance<MyDatabase>())))
          .execute(Drawing("Update design", points.map((e) => e.point).toList(), value));
    }
    Navigator.pop(
      context,
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingArea> pointsList;

  DrawingPainter(this.pointsList);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i].point != null && pointsList[i + 1].point != null) {
        canvas.drawLine(
            pointsList[i].point!.offset, pointsList[i + 1].point!.offset, pointsList[i].areaPaint!);
      } else if (pointsList[i].point != null && pointsList[i + 1].point == null) {
        canvas.drawPoints(
            ui.PointMode.points, [pointsList[i].point!.offset], pointsList[i].areaPaint!);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
