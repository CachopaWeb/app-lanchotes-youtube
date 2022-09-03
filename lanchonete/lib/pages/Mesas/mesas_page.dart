import 'package:flutter/material.dart';
import 'package:lanchonete/Componentes/Item_widget.dart';
import 'package:lanchonete/models/mesas_model.dart';
import 'package:lanchonete/repositories/mesas_repository.dart';

class MesasPage extends StatelessWidget {
  final repository = MesasRepository();

  MesasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<MesasModel>>(
          future: repository.fetchMesas(),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return _buildGridMesas(snapshot.data!);
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro ao buscar informações das mesas',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildItemCard(List<MesasModel> listaMesas) {
    var lista = <Widget>[];
    for (var i = 0; i < listaMesas.length; i++) {
      var mesa = listaMesas[i];
      lista.add(
        ItemWidget(
          status: stringToStatus(mesa.mesEstado),
          index: i + 1,
          valor: mesa.mesValor,
        ),
      );
    }
    return lista;
  }

  GridView _buildGridMesas(List<MesasModel> listaMesas) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      children: _buildItemCard(listaMesas),
    );
  }
}
