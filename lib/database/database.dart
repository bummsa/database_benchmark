enum Database {
  hive('Hive'),
  objectbox('ObjectBox'),
  sembast('Sembast'),
  realm('Realm');

  final String name;

  const Database(this.name);
}
