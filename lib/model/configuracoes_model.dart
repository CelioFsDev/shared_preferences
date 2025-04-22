class ConfiguracoesModel {
  String nome;
  String email;
  double altura;
  bool temaEscuro;
  bool notificacao;

  ConfiguracoesModel({
    required this.nome,
    required this.email,
    required this.altura,
    required this.temaEscuro,
    required this.notificacao,
  });

  factory ConfiguracoesModel.vazio() => ConfiguracoesModel(
        nome: '',
        email: '',
        altura: 0.0,
        temaEscuro: false,
        notificacao: false,
      );

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'altura': altura,
      'temaEscuro': temaEscuro,
      'notificacao': notificacao,
    };
  }

  factory ConfiguracoesModel.fromMap(Map<dynamic, dynamic> map) {
    return ConfiguracoesModel(
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      altura: (map['altura'] ?? 0).toDouble(),
      temaEscuro: map['temaEscuro'] ?? false,
      notificacao: map['notificacao'] ?? false,
    );
  }
}
