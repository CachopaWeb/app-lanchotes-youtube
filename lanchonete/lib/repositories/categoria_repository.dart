import 'package:dio/dio.dart';
import 'package:lanchonete/models/categoria_model.dart';

class CategoriaRepository {
  final dio = Dio();

  Future<List<CategoriaModel>> getCategoria() async {
    try {
      final response = await dio.get('http://localhost:9000/Categorias');
      final lista = response.data as List;
      return lista.map((e) => CategoriaModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getFotoCategoria(int codigo) async {
    try {
      final response =
          await dio.get('http://localhost:9000/Categorias/$codigo/foto');
      return response.data['base64'] as String;
    } catch (e) {
      throw Exception(e);
    }
  }
}
