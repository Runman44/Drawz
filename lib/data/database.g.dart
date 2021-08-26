// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Design extends DataClass implements Insertable<Design> {
  final int id;
  final String name;
  final List<Point?> points;
  final Uint8List imageBytes;
  Design(
      {required this.id,
      required this.name,
      required this.points,
      required this.imageBytes});
  factory Design.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Design(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      points: $DesignsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}points']))!,
      imageBytes: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_bytes'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $DesignsTable.$converter0;
      map['points'] = Variable<String>(converter.mapToSql(points)!);
    }
    map['image_bytes'] = Variable<Uint8List>(imageBytes);
    return map;
  }

  DesignsCompanion toCompanion(bool nullToAbsent) {
    return DesignsCompanion(
      id: Value(id),
      name: Value(name),
      points: Value(points),
      imageBytes: Value(imageBytes),
    );
  }

  factory Design.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Design(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      points: serializer.fromJson<List<Point?>>(json['points']),
      imageBytes: serializer.fromJson<Uint8List>(json['imageBytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'points': serializer.toJson<List<Point?>>(points),
      'imageBytes': serializer.toJson<Uint8List>(imageBytes),
    };
  }

  Design copyWith(
          {int? id,
          String? name,
          List<Point?>? points,
          Uint8List? imageBytes}) =>
      Design(
        id: id ?? this.id,
        name: name ?? this.name,
        points: points ?? this.points,
        imageBytes: imageBytes ?? this.imageBytes,
      );
  @override
  String toString() {
    return (StringBuffer('Design(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('points: $points, ')
          ..write('imageBytes: $imageBytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(points.hashCode, imageBytes.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Design &&
          other.id == this.id &&
          other.name == this.name &&
          other.points == this.points &&
          other.imageBytes == this.imageBytes);
}

class DesignsCompanion extends UpdateCompanion<Design> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<Point?>> points;
  final Value<Uint8List> imageBytes;
  const DesignsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.points = const Value.absent(),
    this.imageBytes = const Value.absent(),
  });
  DesignsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<Point?> points,
    required Uint8List imageBytes,
  })  : name = Value(name),
        points = Value(points),
        imageBytes = Value(imageBytes);
  static Insertable<Design> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<List<Point?>>? points,
    Expression<Uint8List>? imageBytes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (points != null) 'points': points,
      if (imageBytes != null) 'image_bytes': imageBytes,
    });
  }

  DesignsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<List<Point?>>? points,
      Value<Uint8List>? imageBytes}) {
    return DesignsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (points.present) {
      final converter = $DesignsTable.$converter0;
      map['points'] = Variable<String>(converter.mapToSql(points.value)!);
    }
    if (imageBytes.present) {
      map['image_bytes'] = Variable<Uint8List>(imageBytes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DesignsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('points: $points, ')
          ..write('imageBytes: $imageBytes')
          ..write(')'))
        .toString();
  }
}

class $DesignsTable extends Designs with TableInfo<$DesignsTable, Design> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DesignsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _pointsMeta = const VerificationMeta('points');
  late final GeneratedColumnWithTypeConverter<List<Point?>, String?> points =
      GeneratedColumn<String?>('points', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<List<Point?>>($DesignsTable.$converter0);
  final VerificationMeta _imageBytesMeta = const VerificationMeta('imageBytes');
  late final GeneratedColumn<Uint8List?> imageBytes =
      GeneratedColumn<Uint8List?>('image_bytes', aliasedName, false,
          typeName: 'BLOB', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, points, imageBytes];
  @override
  String get aliasedName => _alias ?? 'designs';
  @override
  String get actualTableName => 'designs';
  @override
  VerificationContext validateIntegrity(Insertable<Design> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_pointsMeta, const VerificationResult.success());
    if (data.containsKey('image_bytes')) {
      context.handle(
          _imageBytesMeta,
          imageBytes.isAcceptableOrUnknown(
              data['image_bytes']!, _imageBytesMeta));
    } else if (isInserting) {
      context.missing(_imageBytesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Design map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Design.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DesignsTable createAlias(String alias) {
    return $DesignsTable(_db, alias);
  }

  static TypeConverter<List<Point?>, String> $converter0 =
      const ListOffsetTypeConverter();
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DesignsTable designs = $DesignsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [designs];
}
