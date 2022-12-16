import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Skeleton extends ChangeNotifier {
  String? _name;

  String get name {
    if (_name == null) {
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) {
        _name = value.getString('name');
        notifyListeners();
      });
    }
    return _name ?? 'Saurabh';
  }

  set setName(String name) {
    _name = name;
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      value.setString('name', name);
      notifyListeners();
    });
  }
}
