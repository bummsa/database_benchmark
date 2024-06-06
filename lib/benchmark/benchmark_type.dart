enum BenchmarkType {
  get('Get', 'ms'),
  insert('Insert', 'ms'),
  bulkInsert('Bulk Insert', 'ms'),
  update('Update', 'ms'),
  delete('Delete', 'ms'),
  filterQuery('Filter Query', 'ms'),
  filterSortQuery('Filter & Sort Query', 'ms'),
  dbSize('Database Size', 'KB');

  final String name;

  final String unit;

  const BenchmarkType(this.name, this.unit);
}
