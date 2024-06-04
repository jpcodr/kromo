abstract class LocalStorage {
  Future<void> save(String file, Map<String, dynamic> data);
  Future<void> remove(String file);
  Map<String, dynamic> load(String file);
}