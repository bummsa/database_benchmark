import 'dart:async';

import 'package:database_benchmark/benchmark/impl/hive_executor.dart';
import 'package:database_benchmark/benchmark/impl/objectbox/objectbox_executor.dart';
import 'package:database_benchmark/database/database.dart';
import 'package:database_benchmark/models/fruit_dto.dart';

abstract class BenchmarkExecutor<T> {
  Future<void> prepareDatabase();

  Future<void> tearDown();

  Stream<int> runBenchmark({
    required T db,
    required FutureOr<void> Function(T db) prepareDb,
    required FutureOr<void> Function(T db) benchmark,
  }) async* {
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
      yield watch.elapsedMilliseconds;
    }
  }

  static BenchmarkExecutor getBenchmarkExecutor(Database database) {
    switch (database) {
      case Database.hive:
        return HiveRunner();
      case Database.objectbox:
        return ObjectBoxExecutor();
    }
  }

  Stream<int> insert(List<FruitDto> models);
}
