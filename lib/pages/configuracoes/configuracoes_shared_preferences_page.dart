import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/services/app_storage_service.dart';

class ConfiguracaoSharedPreferencesPage extends StatefulWidget {
  const ConfiguracaoSharedPreferencesPage({super.key});

  @override
  State<ConfiguracaoSharedPreferencesPage> createState() =>
      _ConfiguracaoSharedPreferencesPageState();
}

class _ConfiguracaoSharedPreferencesPageState
    extends State<ConfiguracaoSharedPreferencesPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final alturaController = TextEditingController();

  bool temaEscuro = false;
  bool notificacao = false;

  final storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarConfiguracoes();
  }

  Future<void> carregarConfiguracoes() async {
    nomeController.text =
        (await storage.getValue(STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_NOME)) ?? '';
    emailController.text =
        (await storage.getValue(STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_EMAIL)) ??
            '';

    final altura =
        await storage.getValue(STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_ALTURA);
    alturaController.text = altura?.toString() ?? '';

    temaEscuro =
        await storage.getValue(STORAGE_KEYS.CHAVE_TEMA_ESCURO) ?? false;
    notificacao =
        await storage.getValue(STORAGE_KEYS.CHAVE_NOTIFICACAO) ?? false;

    setState(() {});
  }

  Future<void> salvarConfiguracoes() async {
    await storage.setValue(
        STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_NOME, nomeController.text);
    await storage.setValue(
        STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_EMAIL, emailController.text);

    double? altura = double.tryParse(alturaController.text);
    if (altura != null) {
      await storage.setValue(STORAGE_KEYS.CHAVE_DADOSCADASTRAIS_ALTURA, altura);
    }

    await storage.setValue(STORAGE_KEYS.CHAVE_TEMA_ESCURO, temaEscuro);
    await storage.setValue(STORAGE_KEYS.CHAVE_NOTIFICACAO, notificacao);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configurações salvas com sucesso!')),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: alturaController,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Tema Escuro'),
              subtitle: const Text('Ativar tema escuro'),
              value: temaEscuro,
              onChanged: (value) {
                setState(() {
                  temaEscuro = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Notificações'),
              subtitle: const Text('Ativar notificações'),
              value: notificacao,
              onChanged: (value) {
                setState(() {
                  notificacao = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: salvarConfiguracoes,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
