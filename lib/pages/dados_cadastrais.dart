import 'package:flutter/material.dart';
import 'package:shared_preferences/repositories/linguagens_repository.dart';
import 'package:shared_preferences/repositories/nivel_repository.dart';
import 'package:shared_preferences/shared/widgets/text_label.dart';

class TrilhaDadosCadastrais extends StatefulWidget {
  const TrilhaDadosCadastrais({
    super.key,
  });

  @override
  State<TrilhaDadosCadastrais> createState() => _TrilhaDadosCadastraisState();
}

class _TrilhaDadosCadastraisState extends State<TrilhaDadosCadastrais> {
  TextEditingController nomeController = TextEditingController(text: '');
  var dataNacimentoController = TextEditingController(text: '');
  DateTime? dataNacimento;
  var niveis = [];
  var nivelRepository = NivelRepository();
  var nivelSelecionado = '';
  var linguagens = [];
  var linguagensRepository = LinguagensRepository();
  var linguagensSelecionadas = [];
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  //essa forma fica disponivel onde esta criado
  Text returntext(String texto) {
    return Text(
      texto,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
        title: Text('Perfil'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: salvando
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    //Uma forma de add um texto por função criando widgets
                    TextLabel(
                      texto: 'Name',
                    ),
                    TextField(
                      controller: nomeController,
                    ),
                    //Uma forma de add um texto por widgets
                    TextLabel(
                      texto: 'Data de nascimento',
                    ),

                    TextField(
                      readOnly: true, //para não fazer a escrita
                      controller: dataNacimentoController,
                      onTap: () async {
                        var data = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime(2023, 12, 31));
                        if (data != null) {
                          dataNacimentoController.text = data.toString();
                          dataNacimento = data;
                        }
                      },
                    ),
                    TextLabel(
                      texto: 'Nivel de experiencia ',
                    ),
                    Column(
                        children: niveis
                            .map((nivel) => RadioListTile(
                                dense: true,
                                title: Text(nivel.toString()),
                                selected: nivelSelecionado == nivel,
                                value: nivel.toString(),
                                groupValue: nivelSelecionado,
                                onChanged: (value) {
                                  setState(() {
                                    nivelSelecionado = value.toString();
                                  });
                                }))
                            .toList()),

                    TextLabel(
                      texto: 'linguagens Preferidas',
                    ),

                    Column(
                      children: linguagens
                          .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem.toString()),
                              selected: linguagensSelecionadas == linguagem,
                              value: linguagensSelecionadas.contains(linguagem),
                              onChanged: (value) {
                                if (value!) {
                                  linguagensSelecionadas.add(linguagem);
                                } else {
                                  linguagensSelecionadas.remove(linguagem);
                                }
                                setState(() {});
                              }))
                          .toList(),
                    ),
                    TextLabel(
                      texto: 'Tempo de Experiência',
                    ),
                    DropdownButton(
                        value: tempoExperiencia,
                        isExpanded: true,
                        items: returnItens(50),
                        onChanged: (value) {
                          setState(() {
                            tempoExperiencia = int.parse(value.toString());
                          });
                        }),
                    TextLabel(
                      texto:
                          'Pretenção Salarial. R\$ ${salarioEscolhido.round()}',
                    ),

                    Slider(
                        min: 0,
                        max: 20000,
                        value: salarioEscolhido,
                        onChanged: (double value) {
                          setState(() {
                            salarioEscolhido = value;
                            print(value);
                          });
                        }),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          salvando = false;
                        });

                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Nome deve ser maior que 3 caracteres',
                              ),
                            ),
                          );
                          return;
                        }
                        if (dataNacimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Data de nascimento invalida',
                              ),
                            ),
                          );
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'O nivel deve ser selecionado',
                              ),
                            ),
                          );
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Deve ser selecionado ao menos 1 linguagem',
                              ),
                            ),
                          );
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'O nivel deve ser selecionado',
                              ),
                            ),
                          );
                          return;
                        }
                        if (tempoExperiencia == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Deve ter ao menos 1 ano de experiência',
                              ),
                            ),
                          );
                          return;
                        }
                        if (salarioEscolhido <= 1412) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Pretenção salarial deve ser mais que ZERO',
                              ),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          salvando = true;
                        });

                        Future.delayed(Duration(seconds: 3), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Pretenção salarial deve ser mais que ZERO',
                              ),
                            ),
                          );
                          //não precisa do setState
                          setState(() {
                            salvando = false;
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Salvar',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
