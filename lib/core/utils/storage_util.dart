import "package:get_storage/get_storage.dart";

class StorageUtil {
  StorageUtil(this._storage);

  final GetStorage _storage;

  static StorageUtil? _instance;
  static Future<void> init() async {
    await GetStorage.init();

    if (_instance == null) {
      final GetStorage storage = GetStorage();
      _instance = StorageUtil(storage);
    }
  }

  static Future<void> write(String key, dynamic value) async {
    _instance!._storage.write(key, value);
  }

  static T? read<T>(String key, [T? defaultValue]) {
    return (_instance!._storage.read(key) as T?) ?? defaultValue;
  }

  static Future<void> clearKey(String key) async {
    _instance!._storage.remove(key);
  }

  static Future<void> clearAll() async {
    _instance!._storage.erase();
  }
}
