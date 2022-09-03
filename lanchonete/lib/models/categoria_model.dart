import 'dart:convert';

class CategoriaModel {
  final int codigo;
  final String nome;

  CategoriaModel({required this.codigo, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
    };
  }

  factory CategoriaModel.fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      codigo: map['codigo']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriaModel.fromJson(String source) =>
      CategoriaModel.fromMap(json.decode(source));
}
