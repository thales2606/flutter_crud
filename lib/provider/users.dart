import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};
  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    var id = user.id ?? '';
    if (id.trim().isNotEmpty && _items.containsKey(user.id)) {
      _items.update(
          id,
          (_) => User(
              avatarUrl: user.avatarUrl, email: user.email, name: user.name));
      return;
    }
    id = Random().nextInt(1000).toString();
    _items.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            email: user.email,
            avatarUrl: user.avatarUrl));
    notifyListeners();
  }

  void remove(User user) {
    var id = user.id ?? '';
    if (id.trim().isNotEmpty) {
      _items.remove(id);
      notifyListeners();
    }
  }
}
