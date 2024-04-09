import 'package:flutter/material.dart';
import 'package:shared_preferences/pages/drawer_page.dart';
import 'package:shared_preferences/pages/login_page.dart';

class TrilhaMyApp extends StatelessWidget {
  const TrilhaMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: TrilhaLoginPage(),
    );
  }
}
