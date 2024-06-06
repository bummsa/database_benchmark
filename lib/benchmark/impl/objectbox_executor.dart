import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:logging/logging.dart';

class ObjectBoxExecutor extends BenchmarkExecutor {
  final Logger _logger = Logger('HiveRunner');

  @override
  Future<void> prepareDatabase() async {}

  @override
  Future<void> tearDown() async {}

  @override
  Stream<int> insert(List<FruitDto> models) async* {
    yield 1;
  }
}
