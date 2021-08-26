
import 'package:geo_artz/data/database.dart' hide Design;
import 'package:geo_artz/domain/model/drawing.dart';
import 'package:moor/moor.dart';

class DesignDataSourceDatabase {

  final MyDatabase database;

  DesignDataSourceDatabase(this.database);

  Future<void> store(Drawing design) async {
    return await database.insertNewDesign(
        DesignsCompanion.insert(name: design.name, points: design.points, imageBytes: design.imageBytes!.buffer.asUint8List())
    );
  }

  Future<void> update(Drawing design) async {
    return await database.updateDesign(
        DesignsCompanion.insert(id: Value(design.id!),name: design.name, points: design.points, imageBytes: design.imageBytes!.buffer.asUint8List())
    );
  }

  Stream<List<Drawing>> getDesigns() {
    return database.watchAllDesign();
  }

}

