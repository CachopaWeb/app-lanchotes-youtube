import 'package:dio/dio.dart';
import 'package:lanchonete/models/mesas_model.dart';

class MesasRepository {
  final dio = Dio();

  Future<List<MesasModel>> fetchMesas() async {
    try {
      final response = await dio.get('http://localhost:9000/Mesas');
      final lista = response.data as List;
      return lista.map((e) => MesasModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
