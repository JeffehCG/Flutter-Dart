import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop/data/base_store.dart';

// Persistencia de dados no aparelho
// Iremos utilizar duas bibliotecas de exemplo
// A shared_preferences e a flutter_security_store
// *Importante, a flutter_security_store funciona apenas na versão do android 18 pra cima
class SecurityStore extends BaseStore{
  Future<void> saveString(String key, String value) async {
    final prefs = FlutterSecureStorage();
    prefs.write(key: key, value: value);
  }

  Future<String> getString(String key) async {
    final prefs = FlutterSecureStorage();
    return await prefs.read(key: key);
  }

  Future<void> remove(String key) async {
    final prefs = FlutterSecureStorage();
    return await prefs.delete(key: key);
  }
}
