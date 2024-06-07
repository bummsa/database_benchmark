import 'package:database_benchmark/benchmark/impl/realm/second_dto_for_realm.dart';
import 'package:realm/realm.dart';

part 'fruit_dto_for_realm.realm.dart';

@RealmModel()
class _FruitDtoForRealm {
  @PrimaryKey()
  late int id;
  late String name;
  late String shape;
  late String color;
  late List<String> description;
  late int amount;
  late bool available;
  late $SecondDtoForRealm? secondDto;

}
