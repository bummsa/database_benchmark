// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_dto_for_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SecondDtoForRealm extends $SecondDtoForRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  SecondDtoForRealm(
    int id,
    String name,
    String shape,
    String color,
    int amount,
    bool available, {
    Iterable<String> description = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'shape', shape);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set<RealmList<String>>(
        this, 'description', RealmList<String>(description));
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'available', available);
  }

  SecondDtoForRealm._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get shape => RealmObjectBase.get<String>(this, 'shape') as String;
  @override
  set shape(String value) => RealmObjectBase.set(this, 'shape', value);

  @override
  String get color => RealmObjectBase.get<String>(this, 'color') as String;
  @override
  set color(String value) => RealmObjectBase.set(this, 'color', value);

  @override
  RealmList<String> get description =>
      RealmObjectBase.get<String>(this, 'description') as RealmList<String>;
  @override
  set description(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  int get amount => RealmObjectBase.get<int>(this, 'amount') as int;
  @override
  set amount(int value) => RealmObjectBase.set(this, 'amount', value);

  @override
  bool get available => RealmObjectBase.get<bool>(this, 'available') as bool;
  @override
  set available(bool value) => RealmObjectBase.set(this, 'available', value);

  @override
  Stream<RealmObjectChanges<SecondDtoForRealm>> get changes =>
      RealmObjectBase.getChanges<SecondDtoForRealm>(this);

  @override
  Stream<RealmObjectChanges<SecondDtoForRealm>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SecondDtoForRealm>(this, keyPaths);

  @override
  SecondDtoForRealm freeze() =>
      RealmObjectBase.freezeObject<SecondDtoForRealm>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'shape': shape.toEJson(),
      'color': color.toEJson(),
      'description': description.toEJson(),
      'amount': amount.toEJson(),
      'available': available.toEJson(),
    };
  }

  static EJsonValue _toEJson(SecondDtoForRealm value) => value.toEJson();
  static SecondDtoForRealm _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'shape': EJsonValue shape,
        'color': EJsonValue color,
        'description': EJsonValue description,
        'amount': EJsonValue amount,
        'available': EJsonValue available,
      } =>
        SecondDtoForRealm(
          fromEJson(id),
          fromEJson(name),
          fromEJson(shape),
          fromEJson(color),
          fromEJson(amount),
          fromEJson(available),
          description: fromEJson(description),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SecondDtoForRealm._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, SecondDtoForRealm, 'SecondDtoForRealm', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('shape', RealmPropertyType.string),
      SchemaProperty('color', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('amount', RealmPropertyType.int),
      SchemaProperty('available', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
