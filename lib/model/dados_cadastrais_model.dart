import 'package:hive/hive.dart';
//Utilize o comando abaixo para gerar o arquivo .g.dart //flutter pub run build_runner build
part 'dados_cadastrais_model.g.dart';

@HiveType(typeId: 1)
class DadosCadastraisModel {
  @HiveField(0)
  String nome;

  @HiveField(1)
  DateTime dataNascimento;

  @HiveField(2)
  String nivel;

  @HiveField(3)
  List<String> linguagens;

  @HiveField(4)
  int tempoExperiencia;

  @HiveField(5)
  double salario;

  DadosCadastraisModel({
    required this.nome,
    required this.dataNascimento,
    required this.nivel,
    required this.linguagens,
    required this.tempoExperiencia,
    required this.salario,
  });

  factory DadosCadastraisModel.vazio() {
    return DadosCadastraisModel(
      nome: '',
      dataNascimento: DateTime(2000, 1, 1),
      nivel: '',
      linguagens: [],
      tempoExperiencia: 0,
      salario: 0.0,
    );
  }
}
