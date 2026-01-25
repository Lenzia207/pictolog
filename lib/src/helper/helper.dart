class Helper {
  static Set<T> toggleSelection<T>(
    Set<T> currentSelection,
    T key,
  ) {
    final newSet = Set<T>.from(currentSelection);

    if (newSet.contains(key)) {
      newSet.remove(key);
    } else {
      newSet.add(key);
    }

    return newSet;
  }
}
