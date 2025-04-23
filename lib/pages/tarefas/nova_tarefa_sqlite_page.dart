import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/tarefa.dart';
import 'package:shared_preferences_dio/model/tarefa_sqlite_model.dart';
import 'package:shared_preferences_dio/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:shared_preferences_dio/repositories/tarefa_repository.dart';

class TarefaSqlitePage extends StatefulWidget {
  const TarefaSqlitePage({super.key});

  @override
  State<TarefaSqlitePage> createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  TarefaSqliteRepository tarefasRepository = TarefaSqliteRepository();
  var _tarefas = const <TarefaSqliteModel>[];
  TextEditingController descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefasRepository.obterDados();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: Text("Adicionar Tarefa"),
                content: TextField(controller: descricaoController),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await tarefasRepository.salvar(
                        TarefaSqliteModel(0, descricaoController.text, false),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filtrar não concluidas"),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (bool value) {
                      apenasNaoConcluidos = value;
                      setState(() {
                        obterTarefas();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    key: Key(tarefa.id.toString()),
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefasRepository.remover(tarefa.id);
                      obterTarefas();
                    },
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        value: tarefa.concluido,
                        onChanged: (bool value) async {
                          await tarefasRepository.atualizar(tarefa);
                          obterTarefas();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
