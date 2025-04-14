import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_dio/pages/login_page.dart';

class TrilhaMyApp extends StatefulWidget {
  const TrilhaMyApp({super.key});

  @override
  State<TrilhaMyApp> createState() => _TrilhaMyAppState();
}

class _TrilhaMyAppState extends State<TrilhaMyApp> {
  bool temaEscuro = false;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  void carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    final temaSalvo = prefs.getBool('tema_escuro') ?? false;

    setState(() {
      temaEscuro = temaSalvo;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const SizedBox.shrink(); // ou uma tela de loading
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: const TrilhaLoginPage(),
    );
  }
}
