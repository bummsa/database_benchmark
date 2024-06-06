// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'benchmark/impl/objectbox/fruit_dto_for_objectbox.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 5105430209492763497),
      name: 'FruitDtoForObjectBox',
      lastPropertyId: const obx_int.IdUid(7, 5188599824753261097),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6525864582334735510),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1389866362336064843),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 609669392408910778),
            name: 'shape',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5651953056009852432),
            name: 'color',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 6493913964618340623),
            name: 'description',
            type: 30,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 6867252687170356574),
            name: 'amount',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 5188599824753261097),
            name: 'available',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 5105430209492763497),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    FruitDtoForObjectBox: obx_int.EntityDefinition<FruitDtoForObjectBox>(
        model: _entities[0],
        toOneRelations: (FruitDtoForObjectBox object) => [],
        toManyRelations: (FruitDtoForObjectBox object) => {},
        getId: (FruitDtoForObjectBox object) => object.id,
        setId: (FruitDtoForObjectBox object, int id) {
          object.id = id;
        },
        objectToFB: (FruitDtoForObjectBox object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final shapeOffset = fbb.writeString(object.shape);
          final colorOffset = fbb.writeString(object.color);
          final descriptionOffset = fbb.writeList(
              object.description.map(fbb.writeString).toList(growable: false));
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, shapeOffset);
          fbb.addOffset(3, colorOffset);
          fbb.addOffset(4, descriptionOffset);
          fbb.addInt64(5, object.amount);
          fbb.addBool(6, object.available);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final shapeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final descriptionParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGet(buffer, rootOffset, 12, []);
          final amountParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          final availableParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 16, false);
          final colorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = FruitDtoForObjectBox(
              id: idParam,
              name: nameParam,
              shape: shapeParam,
              description: descriptionParam,
              amount: amountParam,
              available: availableParam,
              color: colorParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [FruitDtoForObjectBox] entity fields to define ObjectBox queries.
class FruitDtoForObjectBox_ {
  /// See [FruitDtoForObjectBox.id].
  static final id = obx.QueryIntegerProperty<FruitDtoForObjectBox>(
      _entities[0].properties[0]);

  /// See [FruitDtoForObjectBox.name].
  static final name =
      obx.QueryStringProperty<FruitDtoForObjectBox>(_entities[0].properties[1]);

  /// See [FruitDtoForObjectBox.shape].
  static final shape =
      obx.QueryStringProperty<FruitDtoForObjectBox>(_entities[0].properties[2]);

  /// See [FruitDtoForObjectBox.color].
  static final color =
      obx.QueryStringProperty<FruitDtoForObjectBox>(_entities[0].properties[3]);

  /// See [FruitDtoForObjectBox.description].
  static final description =
      obx.QueryStringVectorProperty<FruitDtoForObjectBox>(
          _entities[0].properties[4]);

  /// See [FruitDtoForObjectBox.amount].
  static final amount = obx.QueryIntegerProperty<FruitDtoForObjectBox>(
      _entities[0].properties[5]);

  /// See [FruitDtoForObjectBox.available].
  static final available = obx.QueryBooleanProperty<FruitDtoForObjectBox>(
      _entities[0].properties[6]);
}