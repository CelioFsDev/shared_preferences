import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS {
  CHAVE_DADOSCADASTRAIS_NOME,
  CHAVE_DADOSCADASTRAIS_EMAIL,
  CHAVE_DADOSCADASTRAIS_ALTURA,
  CHAVE_DADOSCADASTRAIS_DATA,
  CHAVE_DADOSCADASTRAIS_NIVEL,
  CHAVE_DADOSCADASTRAIS_LINGUAGEM,
  CHAVE_DADOSCADASTRAIS_TEMPO,
  CHAVE_DADOSCADASTRAIS_SALARIO,
  CHAVE_NUMERO_ALEATORIO,
  CHAVE_QUANTIDADE_CLIQUES,
  CHAVE_TEMA_ESCURO,
  CHAVE_NOTIFICACAO,
}

class AppStorageService {
  Future<void> setValue(STORAGE_KEYS key, dynamic value) async {
    final storage = await SharedPreferences.getInstance();
    final keyString = key.name;

    if (value is String) {
      await storage.setString(keyString, value);
    } else if (value is int) {
      await storage.setInt(keyString, value);
    } else if (value is double) {
      await storage.setDouble(keyString, value);
    } else if (value is bool) {
      await storage.setBool(keyString, value);
    } else if (value is List<String>) {
      await storage.setStringList(keyString, value);
    } else {
      throw Exception('Unsupported value type for SharedPreferences');
    }
  }

  Future<dynamic> getValue(STORAGE_KEYS key) async {
    final storage = await SharedPreferences.getInstance();
    final keyString = key.name;
    return storage.get(keyString);
  }

  Future<void> removeValue(STORAGE_KEYS key) async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(key.name);
  }

  Future<void> clearAll() async {
    final storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
