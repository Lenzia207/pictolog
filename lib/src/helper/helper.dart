 import 'package:flutter/foundation.dart';

class Helper {
  static void toggleSelection<T>(
    ValueNotifier<Set<T>> selectedKeys,
    T key,
  ) {
    final newSet = Set<T>.from(selectedKeys.value);

    if (newSet.contains(key)) {
      newSet.remove(key);
    } else {
      newSet.add(key);
    }
    selectedKeys.value = newSet;
  }
}
