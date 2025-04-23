import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/tarefa.dart';
import 'package:shared_preferences_dio/repositories/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefasRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
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
      _tarefas = await tarefasRepository.listarTarefasNaoConcluidas();
    } else {
      _tarefas = await tarefasRepository.listarTarefas();
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
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        print(descricaoController.text);
                        await tarefasRepository
                            .adicionar(Tarefa(descricaoController.text, false));
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        'Salvar',
                      ),
                    ),
                  ],
                );
              });
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
                      }),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    key: Key(tarefa.id),
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefasRepository.remove(tarefa.id);
                      obterTarefas();
                    },
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                          value: tarefa.concluido,
                          onChanged: (bool value) async {
                            await tarefasRepository.alterar(tarefa.id, value);
                            obterTarefas();
                          }),
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
