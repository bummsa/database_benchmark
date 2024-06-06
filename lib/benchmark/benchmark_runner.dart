import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/benchmark/benchmark_type.dart';
import 'package:database_benchmark/database/database.dart';
import 'package:database_benchmark/models/fruit_dto.dart';

class BenchmarkRunner {
  final Map<Database, BenchmarkExecutor> executors = {
    for (var database in Database.values)
      database: BenchmarkExecutor.getBenchmarkExecutor(database)
  };

  Stream<RunnerResult> runBenchmark(
      BenchmarkType benchmark, int amountOfObjects) async* {
    final models = FruitDto.generateDtos(amountOfObjects);

    for (final database in Database.values) {
      final executor = executors[database]!;
      try {
        final resultStream = _runBenchmark(benchmark, executor, models);
        yield* resultStream
            .map((event) => RunnerResult(database, benchmark, event));
      } catch (e) {
        // ignore: avoid_print
        print("error $e");
      } finally {
        await executor.tearDown();
      }
    }
  }

  Stream<int> _runBenchmark(BenchmarkType benchmark, BenchmarkExecutor executor,
      List<FruitDto> models) {
    switch (benchmark) {
      case BenchmarkType.insert:
        return executor.insert(models);
      case BenchmarkType.bulkInsert:
        return executor.bulkInsert(models);
      case BenchmarkType.get:
        return executor.get(models);
      default:
        return const Stream.empty();
    }
  }
}

class RunnerResult {
  final Database database;

  final BenchmarkType benchmark;

  final int value;

  const RunnerResult(this.database, this.benchmark, this.value);
}
