import 'dart:io';

import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/benchmark/benchmark_type.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class HiveRunner extends BenchmarkExecutor {
  final Logger _logger = Logger('HiveRunner');

  @override
  Future<void> prepareDatabase() async {
    _logger.info("Preparing Hive DB ...");
    final s = Stopwatch()..start();

    final dir = await getApplicationDocumentsDirectory();
    print("dir=$dir");
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
    await (await Hive.openBox('testBox')).clear();
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
      benchmark: (db) {
        return _fillDb(models);
      },
    );
  }

  Future<void> _fillDb(List<FruitDto> models) async {
    final box = await Hive.openBox('testBox');

    for (int i = 0; i < models.length; i++) {
      await box.put(i, models[i].toJson());
    }

    await box.close();
  }
}
