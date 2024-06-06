import 'dart:async';

import 'package:database_benchmark/benchmark/impl/hive/hive_executor.dart';
import 'package:database_benchmark/benchmark/impl/objectbox/objectbox_executor.dart';
import 'package:database_benchmark/benchmark/impl/sambast/sembast_executor.dart';
import 'package:database_benchmark/database/database.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:logging/logging.dart';

abstract class BenchmarkExecutor<T> {
  final logger = Logger("BenchmarkExecutor");

  Future<void> prepareDatabase();

  Future<void> tearDown();

  Stream<int> runBenchmark({
    required T db,
    required FutureOr<void> Function(T db) prepareDb,
    required FutureOr<void> Function(T db) benchmark,
  }) async* {
    logger.info("Running benchmark for ${db.runtimeType} ...");
    final watch = Stopwatch();

    try {
      await prepareDb.call(db);
      watch.start();
      final result = benchmark.call(db);
      if (result is Future) {
        await result;
      }
      watch.stop();
    } finally {
      logger.info(
          "Benchmarking for the database ${db.runtimeType} finished! (${watch.elapsedMilliseconds}ms)");
      yield watch.elapsedMilliseconds;
    }
  }

  static BenchmarkExecutor getBenchmarkExecutor(Database database) {
    switch (database) {
      case Database.hive:
        return HiveRunner();
      case Database.objectbox:
        return ObjectBoxExecutor();
      case Database.sembast:
        return SembastExecutor();
    }
  }

  Stream<int> insert(List<FruitDto> models);

  Stream<int> bulkInsert(List<FruitDto> models);

  Stream<int> get(List<FruitDto> models);
}
