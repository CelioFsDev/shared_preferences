import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/services/app_storage_service.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  final storage = AppStorageService();

  int? numeroGerado = 0;
  int? quantidadeDeNumerosGerados = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final numero = await storage.getValue(STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO);
    final total = await storage.getValue(STORAGE_KEYS.CHAVE_QUANTIDADE_CLIQUES);

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

    await storage.setValue(STORAGE_KEYS.CHAVE_NUMERO_ALEATORIO, numeroGerado!);
    await storage.setValue(
        STORAGE_KEYS.CHAVE_QUANTIDADE_CLIQUES, quantidadeDeNumerosGerados!);
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
