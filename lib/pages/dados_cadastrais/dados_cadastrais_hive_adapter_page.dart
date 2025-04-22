import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/dados_cadastrais_model.dart';
import 'package:shared_preferences_dio/repositories/dados_cadastrais_repository.dart';
import 'package:shared_preferences_dio/repositories/linguagens_repository.dart';
import 'package:shared_preferences_dio/repositories/nivel_repository.dart';
import 'package:shared_preferences_dio/shared/widgets/text_label.dart';

class TrilhaDadosCadastrais extends StatefulWidget {
  const TrilhaDadosCadastrais({super.key});

  @override
  State<TrilhaDadosCadastrais> createState() => _TrilhaDadosCadastraisState();
}

class _TrilhaDadosCadastraisState extends State<TrilhaDadosCadastrais> {
  final nomeController = TextEditingController(text: '');
  final dataNacimentoController = TextEditingController(text: '');
  DateTime? dataNacimento;

  final nivelRepository = NivelRepository();
  final linguagensRepository = LinguagensRepository();
  final repository = DadosCadastraisRepository();

  var niveis = [];
  var linguagens = [];
  var linguagensSelecionadas = <String>[];
  var nivelSelecionado = '';
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  bool salvando = false;

  @override
  void initState() {
    super.initState();
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final dados = await repository.carregar();

    nomeController.text = dados.nome;
    dataNacimentoController.text = dados.dataNascimento.toIso8601String();
    dataNacimento = dados.dataNascimento;
    nivelSelecionado = dados.nivel;
    linguagensSelecionadas = dados.linguagens;
    tempoExperiencia = dados.tempoExperiencia;
    salarioEscolhido = dados.salario;

    setState(() {});
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    return List.generate(
      quantidadeMaxima + 1,
      (index) => DropdownMenuItem<int>(
        value: index,
        child: Text(index.toString()),
      ),
    );
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
                          dataNacimento = data;
                          dataNacimentoController.text = data.toIso8601String();
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
                    DropdownButton<int>(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = value!;
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
                        if (nomeController.text.trim().length < 3 ||
                            dataNacimento == null ||
                            nivelSelecionado.isEmpty ||
                            linguagensSelecionadas.isEmpty ||
                            tempoExperiencia == 0 ||
                            salarioEscolhido <= 1412) {
                          _showSnackBar(
                              'Preencha todos os campos corretamente');
                          return;
                        }

                        setState(() => salvando = true);

                        final novo = DadosCadastraisModel(
                          nome: nomeController.text,
                          dataNascimento: dataNacimento!,
                          nivel: nivelSelecionado,
                          linguagens: linguagensSelecionadas,
                          tempoExperiencia: tempoExperiencia,
                          salario: salarioEscolhido,
                        );

                        await repository.salvar(novo);

                        if (mounted) {
                          _showSnackBar('Dados salvos com sucesso!');
                          setState(() => salvando = false);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _showSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }
}
