List<T> filterListByQuery<T>(
  List<T> list,
  String query,
  String Function(T) searchField,
) {
  if (query.isEmpty) return list;

  return list
      .where(
        (item) => searchField(item).toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}
