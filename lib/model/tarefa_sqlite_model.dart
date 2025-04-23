class TarefaSqliteModel {
  int _id = 0;

  String _descricao = "";

  bool _concluido = false;

  TarefaSqliteModel(
    this._id,
    this._descricao,
    this._concluido,
  );
  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get descricao => _descricao;

  bool get concluido => _concluido;

  void set descricao(String descricao) {
    _descricao = descricao;
  }

  void set concluido(bool concluido) {
    _concluido = concluido;
  }
}
