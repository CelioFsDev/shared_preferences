import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final alturaController = TextEditingController();

  bool temaEscuro = false;
  bool notificacao = false;

  late SharedPreferences storage;

  final CHAVE_NOME = 'nome_usuario';
  final CHAVE_EMAIL = 'email_usuario';
  final CHAVE_ALTURA = 'altura_usuario';
  final CHAVE_TEMA_ESCURO = 'tema_escuro';
  final CHAVE_NOTIFICACAO = 'notificacao';

  @override
  void initState() {
    super.initState();
    carregarConfiguracoes();
  }

  Future<void> carregarConfiguracoes() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = storage.getString(CHAVE_NOME) ?? '';
      emailController.text = storage.getString(CHAVE_EMAIL) ?? '';
      alturaController.text =
          (storage.getDouble(CHAVE_ALTURA)?.toString() ?? '');
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
      notificacao = storage.getBool(CHAVE_NOTIFICACAO) ?? false;
    });
  }

  Future<void> salvarConfiguracoes() async {
    await storage.setString(CHAVE_NOME, nomeController.text);
    await storage.setString(CHAVE_EMAIL, emailController.text);

    double? altura = double.tryParse(alturaController.text);
    if (altura != null) {
      await storage.setDouble(CHAVE_ALTURA, altura);
    }

    await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);
    await storage.setBool(CHAVE_NOTIFICACAO, notificacao);

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
