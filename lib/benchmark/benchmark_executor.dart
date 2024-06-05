import 'package:database_benchmark/benchmark/impl/hive_executor.dart';
import 'package:database_benchmark/database/database.dart';
import 'package:database_benchmark/models/fruit_dto.dart';

abstract class BenchmarkExecutor<T> {
  Future<void> prepareDatabase();

  Future<void> tearDown();

  static BenchmarkExecutor getBenchmarkExecutor(Database database) {
    switch (database) {
      case Database.hive:
        return HiveRunner();
    }
  }

  Stream<int> insert(List<FruitDto> models);
}
