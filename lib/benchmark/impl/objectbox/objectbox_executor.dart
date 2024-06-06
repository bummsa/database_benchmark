import 'dart:io';

import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/benchmark/impl/objectbox/fruit_dto_for_objectbox.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:database_benchmark/objectbox.g.dart';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ObjectBoxExecutor extends BenchmarkExecutor {
  final Logger _logger = Logger('ObjectBoxRunner');
  Store? _store;
  Box<FruitDtoForObjectBox>? _fruitBox;

  @override
  Future<void> prepareDatabase() async {
    _logger.info("Preparing ObjectBox DB ...");
    final s = Stopwatch()..start();

    final dir = await getApplicationDocumentsDirectory();
    var homePath = path.join(dir.path, 'objectbox');
    if (await Directory(homePath).exists()) {
      await Directory(homePath).delete(recursive: true);
    }
    await Directory(homePath).create();

    _store = Store(
      getObjectBoxModel(),
      directory: homePath,
    );

    _fruitBox = _store?.box<FruitDtoForObjectBox>();

    s.stop();
    _logger.info(
        "ObjectBox DB preparation done! (${s.elapsedMilliseconds / 1000}s.)");
  }

  @override
  Future<void> tearDown() async {
    _logger.info("Teardown ObjectBox DB ...");

    if (_store != null && !_store!.isClosed()) {
      _fruitBox?.removeAll();
      _store?.close();
    }
    _logger.info("Teardown ObjectBox DB done!");
  }

  @override
  Stream<int> insert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) {
        return prepareDatabase();
      },
      benchmark: (db) async {
        // testing if the DTO can be used directly
        final mappedModels = mapToObjectBox(models);
        for (int i = 0; i < mappedModels.length; i++) {
          _fruitBox!.put(mappedModels[i]);
        }
        return Future.value();
      },
    );
  }

  @override
  Stream<int> bulkInsert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) {
        return prepareDatabase();
      },
      benchmark: (db) async {
        _fruitBox!.putMany(mapToObjectBox(models));
        _store?.close();
        return Future.value();
      },
    );
  }

  @override
  Stream<int> get(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) async {
        await prepareDatabase();

        _fruitBox!.putMany(mapToObjectBox(models));
      },
      benchmark: (db) async {
        final all = _fruitBox?.getAll() ?? [];
        _logger.info("ObjectBox: Found ${all.length} entries");

        _store?.close();
        if (all.length != models.length) {
          throw Exception("ObjectBox: Cannot get all values");
        }
        return Future.value();
      },
    );
  }

  ///
  Future<void> _fillDb(List<FruitDto> models) async {
    if (_fruitBox == null) {
      throw StateError("Database not initialized");
    }

    _fruitBox!.putMany(mapToObjectBox(models));
  }

  List<FruitDtoForObjectBox> mapToObjectBox(List<FruitDto> models) {
    final s = Stopwatch()..start();
    final result = models
        .map(
          (e) => FruitDtoForObjectBox.fromJson(e.toJson()),
        )
        .toList();
    s.stop();

    _logger.info(
      "Objectbox: Mapping list of DTO to FruitDtoForObjectbox finished in ${s.elapsedMilliseconds}ms.",
    );
    return result;
  }
}
