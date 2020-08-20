import 'package:flutter/foundation.dart';

getOrNull<T>(List<T> items, int index) {
  if (items == null) return null;
  if (index < 0 || index >= items.length) return null;
  return items[index];
}
