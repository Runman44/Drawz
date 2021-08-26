import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:geo_artz/domain/model/drawing.dart';
import 'package:geo_artz/domain/model/point.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'database.g.dart';


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}


class Designs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get points =>
      text().map(const ListOffsetTypeConverter())();
  BlobColumn get imageBytes => blob()();
}


@UseMoor(tables: [Designs])
class MyDatabase extends _$MyDatabase {

  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Drawing>> getAllDesign() => select(designs)
      .map((row) => Drawing(row.name, row.points, ByteData.sublistView(row.imageBytes), row.id))
      .get();
  Stream<List<Drawing>> watchAllDesign() => select(designs)
      .map((row) => Drawing(row.name, row.points, ByteData.sublistView(row.imageBytes), row.id))
      .watch();
  Future updateDesign(DesignsCompanion entry) => update(designs).replace(entry);
  Future insertNewDesign(DesignsCompanion entry) => into(designs).insert(entry);
  Future deleteDesign(DesignsCompanion entry) => delete(designs).delete(entry);
}

class ListOffsetTypeConverter extends TypeConverter<List<Point?>, String> {

  const ListOffsetTypeConverter();

  @override
  List<Point?>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return [];
    }
    var tagsJson = json.decode(fromDb);

    List<Point?> point = List<Point?>.from(tagsJson.map((model)=> Point.fromJson(model)));
    return point;
  }

  @override
  String? mapToSql(List<Point?>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}