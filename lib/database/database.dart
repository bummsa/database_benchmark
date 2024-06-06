enum Database {
  hive('Hive'),
  objectbox('ObjectBox'),
  sembast('Sembast');

  final String name;

  const Database(this.name);
}
