import 'dart:io';

import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class HiveRunner extends BenchmarkExecutor {
  final Logger _logger = Logger('HiveRunner');
  final String _boxName = "testBox";

  @override
  Future<void> prepareDatabase() async {
    _logger.info("Preparing Hive DB ...");
    final s = Stopwatch()..start();

    final dir = await getApplicationDocumentsDirectory();
    var homePath = path.join(dir.path, 'hive');
    if (await Directory(homePath).exists()) {
      await Directory(homePath).delete(recursive: true);
    }
    await Directory(homePath).create();
    Hive.init(homePath);

    s.stop();
    _logger
        .info("Hive DB preparation done! (${s.elapsedMilliseconds / 1000}s.)");
  }

  @override
  Future<void> tearDown() async {
    _logger.info("Teardown Hive DB ...");
    await (await Hive.openBox(_boxName)).clear();
    await Hive.close();
    _logger.info("Teardown Hive DB done!");
  }

  @override
  Stream<int> insert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) {
        return prepareDatabase();
      },
      benchmark: (db) async {
        final box = await Hive.openBox(_boxName);

        for (int i = 0; i < models.length; i++) {
          await box.put(i, models[i].toJson());
        }

        return box.close();
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
      benchmark: (db) {
        return _fillDb(models);
      },
    );
  }

  @override
  Stream<int> get(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) async {
        await prepareDatabase();
        return _fillDb(models);
      },
      benchmark: (db) async {
        final box = await Hive.openBox(_boxName);
        final all = box.values.toList();
        _logger.info("ObjectBox: Found ${all.length} entries");

        await Hive.close();
        if (all.length != models.length) {
          throw Exception("Hive: Cannot get all values");
        }
      },
    );
  }

  // fill in "bulk" mode
  Future<void> _fillDb(List<FruitDto> models) async {
    final box = await Hive.openBox(_boxName);

    final s = Stopwatch()..start();
    final map = {};
    for (int i = 0; i < models.length; i++) {
      map.putIfAbsent(i, () => models[i].toJson());
    }
    s.stop();
    _logger.info(
      "Hive: Mapping list of DTO to Map<int, Map<String, dynamic>> finished in ${s.elapsedMilliseconds}ms.",
    );

    await box.putAll(map);
    await box.close();
  }
}
