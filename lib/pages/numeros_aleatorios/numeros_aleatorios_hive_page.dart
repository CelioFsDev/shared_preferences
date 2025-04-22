import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences_dio/services/app_storage_service.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  late Box boxNumerosAleatorios;

  int? numeroGerado = 0;
  int? quantidadeDeNumerosGerados = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box(
          'box_numeros_aleatorios'); // Verifica se a caixa já está aberta
    } else {
      boxNumerosAleatorios = await Hive.openBox(
          'box_numeros_aleatorios'); // Abre a caixa se não estiver aberta
    }
    final numero =
        await boxNumerosAleatorios.get(STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO) ??
            0;
    final total =
        await boxNumerosAleatorios.get(STORAGE_KEYS.CHAVE_QUANTIDADE_CLIQUES) ??
            0;

    setState(() {
      numeroGerado = numero ?? 0;
      quantidadeDeNumerosGerados = total ?? 0;
    });
  }

  void gerarNumeroAleatorio() async {
    final random = Random();

    setState(() {
      numeroGerado = random.nextInt(100);
      quantidadeDeNumerosGerados = (quantidadeDeNumerosGerados ?? 0) + 1;
    });

    boxNumerosAleatorios.put(
        STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO.name.toString(), numeroGerado!);
    boxNumerosAleatorios.put(
        STORAGE_KEYS.CHAVE_QUANTIDADE_CLIQUES.name.toString(), quantidadeDeNumerosGerados!);
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
          onPressed: gerarNumeroAleatorio,
          child: const Icon(Icons.add),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null
                    ? 'Clique no botão para gerar um número aleatório'
                    : 'Número gerado: $numeroGerado',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
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
    );
  }
}
