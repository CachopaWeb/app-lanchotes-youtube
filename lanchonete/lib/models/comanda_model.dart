import 'dart:convert';

class Itens {
  final int cpCodigo;
  final int cpPro;
  final double cpQuantidade;
  final double cpValor;
  final String nome;
  final String cpObs;

  Itens({
    required this.cpCodigo,
    required this.cpPro,
    required this.cpQuantidade,
    required this.cpValor,
    required this.nome,
    required this.cpObs,
  });

  Map<String, dynamic> toMap() {
    return {
      'cpCodigo': cpCodigo,
      'cpPro': cpPro,
      'cpQuantidade': cpQuantidade,
      'cpValor': cpValor,
      'nome': nome,
      'cpObs': cpObs,
    };
  }

  factory Itens.fromMap(Map<String, dynamic> map) {
    return Itens(
      cpCodigo: map['cpCodigo']?.toInt() ?? 0,
      cpPro: map['cpPro']?.toInt() ?? 0,
      cpQuantidade: map['cpQuantidade']?.toDouble() ?? 0.0,
      cpValor: map['cpValor']?.toDouble() ?? 0.0,
      nome: map['nome'] ?? '',
      cpObs: map['cpObs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Itens.fromJson(String source) => Itens.fromMap(json.decode(source));
}

class ComandaModel {
  final int comCodigo;
  final int comMesa;
  final double comValor;
  List<Itens>? itens;

  ComandaModel(
      {required this.comCodigo,
      required this.comMesa,
      required this.comValor,
      required this.itens});

  Map<String, dynamic> toMap() {
    return {
      'comCodigo': comCodigo,
      'comMesa': comMesa,
      'comValor': comValor,
      'itens': itens?.map((x) => x.toMap()).toList(),
    };
  }

  factory ComandaModel.fromMap(Map<String, dynamic> map) {
    return ComandaModel(
      comCodigo: map['comCodigo']?.toInt() ?? 0,
      comMesa: map['comMesa']?.toInt() ?? 0,
      comValor: map['comValor']?.toDouble() ?? 0.0,
      itens: map['itens'] != null
          ? List<Itens>.from(map['itens']?.map((x) => Itens.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComandaModel.fromJson(String source) =>
      ComandaModel.fromMap(json.decode(source));

  double get total =>
      itens!.map((e) => e.cpValor).reduce((value, element) => value + element);
}
