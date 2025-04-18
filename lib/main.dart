import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences_dio/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);//Não funciona na web
  runApp(TrilhaMyApp());
}
