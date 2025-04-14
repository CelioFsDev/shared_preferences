import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_dio/repositories/linguagens_repository.dart';
import 'package:shared_preferences_dio/repositories/nivel_repository.dart';
import 'package:shared_preferences_dio/shared/widgets/text_label.dart';

class TrilhaDadosCadastrais extends StatefulWidget {
  const TrilhaDadosCadastrais({super.key});

  @override
  State<TrilhaDadosCadastrais> createState() => _TrilhaDadosCadastraisState();
}

class _TrilhaDadosCadastraisState extends State<TrilhaDadosCadastrais> {
  TextEditingController nomeController = TextEditingController(text: '');
  TextEditingController dataNacimentoController =
      TextEditingController(text: '');
  DateTime? dataNacimento;

  var niveis = [];
  var nivelRepository = NivelRepository();
  var nivelSelecionado = '';

  var linguagens = [];
  var linguagensRepository = LinguagensRepository();
  var linguagensSelecionadas = <String>[];

  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  bool salvando = false;

  late SharedPreferences prefs;

  final String CHAVE_NOME = 'nome';
  final String CHAVE_DATA = 'data_nascimento';
  final String CHAVE_NIVEL = 'nivel';
  final String CHAVE_LINGUAGENS = 'linguagens';
  final String CHAVE_TEMPO = 'tempo';
  final String CHAVE_SALARIO = 'salario';

  @override
  void initState() {
    super.initState();
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    carregarDados();
  }

  Future<void> carregarDados() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      nomeController.text = prefs.getString(CHAVE_NOME) ?? '';
      dataNacimentoController.text = prefs.getString(CHAVE_DATA) ?? '';
      nivelSelecionado = prefs.getString(CHAVE_NIVEL) ?? '';
      linguagensSelecionadas = prefs.getStringList(CHAVE_LINGUAGENS) ?? [];
      tempoExperiencia = prefs.getInt(CHAVE_TEMPO) ?? 0;
      salarioEscolhido = prefs.getDouble(CHAVE_SALARIO) ?? 0;
    });

    if (dataNacimentoController.text.isNotEmpty) {
      dataNacimento = DateTime.tryParse(dataNacimentoController.text);
    }
  }

  Text returntext(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }

  List<DropdownMenuItem> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Perfil'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: salvando
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    const TextLabel(texto: 'Nome'),
                    TextField(controller: nomeController),
                    const TextLabel(texto: 'Data de nascimento'),
                    TextField(
                      readOnly: true,
                      controller: dataNacimentoController,
                      onTap: () async {
                        var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime(2025, 12, 31),
                        );
                        if (data != null) {
                          dataNacimentoController.text = data.toString();
                          dataNacimento = data;
                        }
                      },
                    ),
                    const TextLabel(texto: 'Nível de experiência'),
                    Column(
                      children: niveis.map((nivel) {
                        return RadioListTile(
                          dense: true,
                          title: Text(nivel.toString()),
                          selected: nivelSelecionado == nivel,
                          value: nivel.toString(),
                          groupValue: nivelSelecionado,
                          onChanged: (value) {
                            setState(() {
                              nivelSelecionado = value.toString();
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const TextLabel(texto: 'Linguagens Preferidas'),
                    Column(
                      children: linguagens.map((linguagem) {
                        return CheckboxListTile(
                          dense: true,
                          title: Text(linguagem.toString()),
                          selected: linguagensSelecionadas.contains(linguagem),
                          value: linguagensSelecionadas.contains(linguagem),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                linguagensSelecionadas.add(linguagem);
                              } else {
                                linguagensSelecionadas.remove(linguagem);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const TextLabel(texto: 'Tempo de Experiência'),
                    DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      },
                    ),
                    TextLabel(
                        texto:
                            'Pretensão Salarial: R\$ ${salarioEscolhido.round()}'),
                    Slider(
                      min: 0,
                      max: 20000,
                      value: salarioEscolhido,
                      onChanged: (value) {
                        setState(() {
                          salarioEscolhido = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Nome deve ser maior que 3 caracteres'),
                            ),
                          );
                          return;
                        }

                        if (dataNacimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data de nascimento inválida'),
                            ),
                          );
                          return;
                        }

                        if (nivelSelecionado.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('O nível deve ser selecionado'),
                            ),
                          );
                          return;
                        }

                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Selecione ao menos 1 linguagem'),
                            ),
                          );
                          return;
                        }

                        if (tempoExperiencia == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Deve ter ao menos 1 ano de experiência'),
                            ),
                          );
                          return;
                        }

                        if (salarioEscolhido <= 1412) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Pretensão salarial deve ser maior que o salário mínimo'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          salvando = true;
                        });

                        await prefs.setString(CHAVE_NOME, nomeController.text);
                        await prefs.setString(
                            CHAVE_DATA, dataNacimento.toString());
                        await prefs.setString(CHAVE_NIVEL, nivelSelecionado);
                        await prefs.setStringList(
                            CHAVE_LINGUAGENS, linguagensSelecionadas);
                        await prefs.setInt(CHAVE_TEMPO, tempoExperiencia);
                        await prefs.setDouble(CHAVE_SALARIO, salarioEscolhido);

                        await Future.delayed(const Duration(seconds: 2));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Dados salvos com sucesso!')),
                        );

                        setState(() {
                          salvando = false;
                        });

                        Navigator.pop(context);
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
