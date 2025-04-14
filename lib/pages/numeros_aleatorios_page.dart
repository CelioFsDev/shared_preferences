import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  late SharedPreferences storage;
  int? numeroGerado = 0;
  int? quantidadeDeNumerosGerados = 0;
  final CHAVE_NUMERO_ALEATORIO = 'numeroGerado';
  final CHAVE_QUANTIDADE_CLIQUES = 'quantidade_cliques';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
      print('Número gerado: $numeroGerado');
      quantidadeDeNumerosGerados = storage.getInt(CHAVE_QUANTIDADE_CLIQUES);
      print('Quantidade de números gerados: $quantidadeDeNumerosGerados');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de Números Aleatórios'),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(100);
              quantidadeDeNumerosGerados =
                  (quantidadeDeNumerosGerados ?? 0) + 1;
            });
            storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
            storage.setInt(
                CHAVE_QUANTIDADE_CLIQUES, quantidadeDeNumerosGerados!);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.amber,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text(
                  numeroGerado.toString() == 'null'
                      ? 'Clique no botão para gerar um número aleatório'
                      : 'Número gerado: $numeroGerado',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  quantidadeDeNumerosGerados == null
                      ? 'Clique no botão para gerar um número aleatório'
                      : 'Número de cliques: $quantidadeDeNumerosGerados',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
