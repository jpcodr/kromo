import 'dart:convert';

import 'package:kromo/domain/repositories/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl extends LocalStorage {

  final SharedPreferences prefs;

  LocalStorageImpl(this.prefs);
  
  @override
  Future<void> remove(String file) {
    return prefs.remove(file);
  }

  @override
  Future<void> save(String file, Map<String, dynamic> data) {
    return prefs.setString(file, jsonEncode(data));
  }

  @override
  Map<String, dynamic> load(String file) {
    final data = prefs.getString(file);

    return Map<String, dynamic>.from(jsonDecode(data ?? '{}'));
  }
  
  @override
  Future<void> clear() async {
    await prefs.clear();
  }

}