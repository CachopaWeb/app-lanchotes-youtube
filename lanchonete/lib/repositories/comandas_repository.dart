import 'package:dio/dio.dart';
import 'package:lanchonete/models/comanda_model.dart';

class ComandaRepository {
  final dio = Dio();

  Future<ComandaModel> fetchComanda(int mesa) async {
    try {
      final response = await dio.get('http://localhost:9000/Comandas/$mesa');
      return ComandaModel.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
