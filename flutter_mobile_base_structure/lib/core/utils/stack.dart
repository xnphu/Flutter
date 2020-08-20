import 'dart:collection';

import 'package:flutter/foundation.dart';

class StackData<T> {
  ListQueue<T> _list = ListQueue();

  /// check if the stack is empty.
  bool get isEmpty => _list.isEmpty;

  /// check if the stack is not empty.
  bool get isNotEmpty => _list.isNotEmpty;

  /// push element in top of the stack.
  void push(T e) {
    _list.addLast(e);
    print('stack top ${this.top()} count ${this.count()}');
  }

  /// get the top of the stack and delete it.
  T pop() {
    T res = _list.last;
    _list.removeLast();
    print('stack top ${this.top()} count ${this.count()}');
    return res;
  }

  /// get the top of the stack without deleting it.
  T top() {
    return _list.last;
  }

  T first() {
    return _list.first;
  }

  void popAll() {
    _list.clear();
  }

  void popUntil({@required T stop}) {
    while (top() != stop) {
      pop();
    }
    print('stack top ${this.top()} count ${this.count()}');
  }

  void popToRoot() {
    if (_list.length > 1) {
      final ListQueue<T> tempList = ListQueue();
      tempList.add(_list.first);
      _list.clear();
      _list = tempList;
    }
    print('stack top ${this.top()} count ${this.count()}');
  }

  T elementAt(int index) {
    return _list.elementAt(index);
  }

  int count() {
    return _list.length;
  }
}
