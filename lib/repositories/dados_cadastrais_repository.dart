import 'package:hive/hive.dart';
import '../model/dados_cadastrais_model.dart';

class DadosCadastraisRepository {
  static const _boxName = 'box_dados_cadastrais';
  static const _key = 'perfil';

  Future<void> salvar(DadosCadastraisModel dados) async {
    final box = await Hive.openBox<DadosCadastraisModel>(_boxName);
    await box.put(_key, dados);
  }

  Future<DadosCadastraisModel> carregar() async {
    final box = await Hive.openBox<DadosCadastraisModel>(_boxName);
    return box.get(_key) ?? DadosCadastraisModel.vazio();
  }
}
