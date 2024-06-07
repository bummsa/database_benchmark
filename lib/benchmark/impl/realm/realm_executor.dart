import 'dart:io';

import 'package:database_benchmark/benchmark/benchmark_executor.dart';
import 'package:database_benchmark/benchmark/impl/realm/fruit_dto_for_realm.dart';
import 'package:database_benchmark/models/fruit_dto.dart';
import 'package:realm/realm.dart';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class RealmExecutor extends BenchmarkExecutor {
  final Logger _logger = Logger('RealmExecutor');
  Realm? _realm;

  @override
  Future<void> prepareDatabase() async {
    _logger.info("Preparing Realm DB ...");
    final s = Stopwatch()..start();

    final dir = await getApplicationDocumentsDirectory();
    var homePath = path.join(dir.path, 'realm');
    if (await Directory(homePath).exists()) {
      await Directory(homePath).delete(recursive: true);
    }
    await Directory(homePath).create();

    final config = Configuration.local([FruitDtoForRealm.schema],
        path: path.join(homePath, 'default.realm'));
    _realm = Realm(config);

    s.stop();
    _logger
        .info("Realm DB preparation done! (${s.elapsedMilliseconds / 1000}s.)");
  }

  @override
  Future<void> tearDown() async {
    _logger.info("Teardown Realm DB ...");

    if (_realm != null && !_realm!.isClosed) {
      //   _realm!.write(() {
      //     _realm!.deleteAll<FruitDtoForRealm>();
      //   });
      _realm!.close();
    }

    _logger.info("Teardown Realm DB done!");
  }

  @override
  Stream<int> insert(List<FruitDto> models) {
    return runBenchmark(
      db: this,
      prepareDb: (db) {
        return prepareDatabase();
      },
      benchmark: (db) async {
        final mappedModels = mapToRealm(models);
        _realm!.write(() {
          for (final model in mappedModels) {
            _realm!.add(model);
          }
        });
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
        final mappedModels = mapToRealm(models);
        _realm!.write(() {
          _realm!.addAll(mappedModels);
        });
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
        final mappedModels = mapToRealm(models);
        _realm!.write(() {
          _realm!.addAll(mappedModels);
        });
        return Future.value();
      },
      benchmark: (db) async {
        final all = _realm!.all<FruitDtoForRealm>();
        _logger.info("Realm: Found ${all.length} entries");
        for (int i = 0; i < all.length; i++) {
          all[i];
        }
        if (all.length != models.length) {
          throw Exception("Realm: Cannot get all values");
        }
        return Future.value();
      },
    );
  }

  Future<void> _fillDb(List<FruitDto> models) async {
    if (_realm == null || _realm!.isClosed) {
      throw StateError("Database not initialized");
    }

    final mappedModels = mapToRealm(models);
    _realm!.write(() {
      _realm!.addAll(mappedModels);
    });
  }

  List<FruitDtoForRealm> mapToRealm(List<FruitDto> models) {
    final s = Stopwatch()..start();

    final List<FruitDtoForRealm> result =
        models.map((e) => modelToRealm(e)).toList();
    s.stop();

    _logger.info(
      "Realm: Mapping list of DTO to FruitDtoForRealm finished in ${s.elapsedMilliseconds}ms.",
    );
    return result;
  }

  FruitDto realmToDto(FruitDtoForRealm realmModel) {
    return FruitDto(
      id: realmModel.id,
      name: realmModel.name,
      shape: realmModel.shape,
      color: realmModel.color,
      description: realmModel.description,
      amount: realmModel.amount,
      available: realmModel.available,
    );
  }

  FruitDtoForRealm modelToRealm(FruitDto model) {
    return FruitDtoForRealm(
        description: RealmList(model.description),
        model.containerId!,
        model.name,
        model.shape,
        model.color,
        model.amount,
        model.available);
  }
}
