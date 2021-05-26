import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/data/base_store.dart';

// Persistencia de dados no aparelho
// Iremos utilizar duas bibliotecas de exemplo
// A shared_preferences e a flutter_security_store
// *Importante, a flutter_security_store funciona apenas na versão do android 18 pra cima
class Store extends BaseStore {
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
