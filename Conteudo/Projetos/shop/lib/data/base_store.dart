import 'dart:convert';

abstract class BaseStore {
  Future<void> saveString(String key, String value);

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, json.encode(value));
  }

  Future<String> getString(String key);

  Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return json.decode(await getString(key));
    } catch (e) {
      return null;
    }
  }

  Future<void> remove(String key);
}
