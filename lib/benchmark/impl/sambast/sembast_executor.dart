import 'dart:io';

import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart' as sem;
import 'package:path/path.dart' as path;

import 'package:sembast/sembast_io.dart';

class SembastExecutor extends BenchmarkExecutor {
  late final Directory dir;
  late final File dbPath;

  late sem.Database dbClient;
  late sem.StoreRef<int, Map<String, dynamic>> _store;

  @override
  Future<void> prepareDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    var file = File(path.join(dir.path, 'sembast/sembast.db'));
    if (file.existsSync()) {
      await file.delete();
    }

    dbClient = await databaseFactoryIo.openDatabase(file.path);
    _store = sem.StoreRef.main();
  }

  @override
  Future<void> tearDown() async {
    await dbClient.close();
  }

  @override
  Stream<int> insert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) => prepareDatabase(),
      benchmark: (db) async {
        for (var model in models) {
          await _store.add(dbClient, model.toJson());
        }
        return Future.value();
      },
    );
  }

  @override
  Stream<int> bulkInsert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) => prepareDatabase(),
      benchmark: (db) async {
        final entries = models.map((record) => record.toJson()).toList();
        await _store.addAll(dbClient, entries);
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
        await _fillDb(models);
      },
      benchmark: (db) async {
        final records = await _store.find(dbClient);
        if (records.length != models.length) {
          throw Exception("Sembast: Cannot get all values");
        }
      },
    );
  }

  Future<void> _fillDb(List<FruitDto> models) {
    final entries = models.map((record) => record.toJson()).toList();
    return _store.addAll(dbClient, entries);
  }
}
