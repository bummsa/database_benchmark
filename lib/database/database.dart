enum Database {
  hive('Hive'),
  objectbox('ObjectBox');

  final String name;

  const Database(this.name);
}
