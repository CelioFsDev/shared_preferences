import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/configuracoes_model.dart';
import 'package:shared_preferences_dio/repositories/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  final _repo = ConfiguracoesRepository();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final alturaController = TextEditingController();

  bool temaEscuro = false;
  bool notificacao = false;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() async {
    final dados = await _repo.carregar();
    setState(() {
      nomeController.text = dados.nome;
      emailController.text = dados.email;
      alturaController.text = dados.altura.toString();
      temaEscuro = dados.temaEscuro;
      notificacao = dados.notificacao;
    });
  }

  void _salvar() {
    final model = ConfiguracoesModel(
      nome: nomeController.text,
      email: emailController.text,
      altura: double.tryParse(alturaController.text) ?? 0.0,
      temaEscuro: temaEscuro,
      notificacao: notificacao,
    );

    _repo.salvar(model);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configurações salvas com sucesso!'),
      ),
    );
    Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: alturaController,
              decoration: const InputDecoration(labelText: 'Altura'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Tema Escuro'),
              value: temaEscuro,
              onChanged: (v) => setState(() => temaEscuro = v),
            ),
            SwitchListTile(
              title: const Text('Notificações'),
              value: notificacao,
              onChanged: (v) => setState(() => notificacao = v),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvar,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
