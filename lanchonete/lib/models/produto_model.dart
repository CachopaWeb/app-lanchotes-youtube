import 'dart:convert';

class ProdutosModel {
  final int codigo;
  final String nome;
  final double valor;

  ProdutosModel(
      {required this.codigo, required this.nome, required this.valor});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'valor': valor,
    };
  }

  factory ProdutosModel.fromMap(Map<String, dynamic> map) {
    return ProdutosModel(
      codigo: map['codigo']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutosModel.fromJson(String source) =>
      ProdutosModel.fromMap(json.decode(source));
}
