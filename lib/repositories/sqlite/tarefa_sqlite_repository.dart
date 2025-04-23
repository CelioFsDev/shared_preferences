import 'package:shared_preferences_dio/model/tarefa_sqlite_model.dart';
import 'sqlite_database.dart';
class TarefaSqliteRepository {
  
  Future<List<TarefaSqliteModel>> obterDados() async{
    List<TarefaSqliteModel> tarefas = [];
    final db = await SQLiteDatabase().obterDatabase();
    var result = await db.rawQuery('SELECT id, descricao, concluida FROM TAREFAS');
    for (var element in result) {
      tarefas.add(TarefaSqliteModel(
        int.parse(element['id'].toString()),
         element['descricao'].toString(),
         bool.parse(element['concluida'].toString()),
           ));}
    return tarefas;
  }

  Future<void> salvar(TarefaSqliteModel tarefa) async {
    final db = await SQLiteDatabase().obterDatabase();
    await db.rawInsert(
      'INSERT INTO TAREFAS (descricao, concluida) VALUES (?, ?)',
      [tarefa.descricao, tarefa.concluido ? 1 : 0],
    );
  }

    Future<void> atualizar(TarefaSqliteModel tarefa) async {
    final db = await SQLiteDatabase().obterDatabase();
    await db.rawInsert(
      'UPDATE TAREFAS SET descricao = ?, concluida = ? WHERE id = ?',
      [
        tarefa.descricao,
        tarefa.concluido ? 1 : 0,
        tarefa.id,
      ],
    );
  }

  Future<void> remover(int id) async {
    final db = await SQLiteDatabase().obterDatabase();
    await db.rawDelete(
      'DELETE FROM TAREFAS WHERE id = ?',
      [id],
    );
  }
}