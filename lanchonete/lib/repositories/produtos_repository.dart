import 'package:dio/dio.dart';
import 'package:lanchonete/models/produto_model.dart';

class ProdutosRepository {
  final dio = Dio();

  Future<List<ProdutosModel>> fetchProdutosPorCategoria(int categoria) async {
    try {
      final response =
          await dio.get('http://localhost:9000/Produtos?categoria=$categoria');
      final list = response.data as List;
      return list.map((e) => ProdutosModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> fetchFotoProduto(int codigo) async {
    try {
      final response =
          await dio.get('http://localhost:9000/Produtos/$codigo/foto');
      return response.data['base64'] as String;
    } catch (e) {
      throw Exception(e);
    }
  }
}
