import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences_dio/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());

  runApp(const TrilhaMyApp());
}
