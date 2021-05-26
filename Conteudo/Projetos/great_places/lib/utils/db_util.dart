import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbUtil {
  static Future<sql.Database> database() async {
    // Trabalhando com Sqlite
    final dbPath = await sql.getDatabasesPath();
    // Abrindo o banco de dados
    return sql.openDatabase(
        // Caso seja a primeira execução, ele criara o banco e executara o metodo onCreate
        path.join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      // Caso de um conflito de Id, o dado sera substituido
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
