import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''CREATE TABLE TAREFAS (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   descricao TEXT NOT NULL,
   concluida INTEGER NOT NULL DEFAULT 0,
  ); ''',
};

class SQLiteDatabase {
  static Database? db;

  Future<Database> obterDatabase() async {
    if (db == null) {
      return iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDeDados() async {
    var db = await openDatabase(
      path.join(await getDatabasesPath(), 'database.db'),
      version: scripts.length, // Número de versões do banco de dados
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= version; i++) {
          await db.execute(scripts[i]!); // Adicionado await
          if (kDebugMode) {
            print('Criando tabela ${scripts[i]}');
          }
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          await db.execute(scripts[i]!); // Adicionado await
          if (kDebugMode) {
            print('Atualizando tabela ${scripts[i]}');
          }
        }
      },
    );
    return db;
  }
}
