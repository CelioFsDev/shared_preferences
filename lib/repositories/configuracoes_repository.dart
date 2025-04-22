import 'package:hive/hive.dart';
import '../model/configuracoes_model.dart';

class ConfiguracoesRepository {
  static const String boxName = 'box_configuracoes';
  static const String key = 'config';

  Future<void> salvar(ConfiguracoesModel dados) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, dados.toMap());
  }

  Future<ConfiguracoesModel> carregar() async {
    final box = await Hive.openBox(boxName);
    final map = box.get(key);
    if (map == null) return ConfiguracoesModel.vazio();
    return ConfiguracoesModel.fromMap(map);
  }
}
