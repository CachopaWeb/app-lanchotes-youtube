import 'package:flutter/material.dart';
import 'package:lanchonete/core/app_colors.dart';
import 'package:lanchonete/core/app_textStyles.dart';
import 'package:lanchonete/models/comanda_model.dart';
import 'package:lanchonete/repositories/comandas_repository.dart';

class ConsumoPage extends StatelessWidget {
  final repository = ComandaRepository();
  final int numeroMesa;
  ConsumoPage({
    Key? key,
    required this.numeroMesa,
  }) : super(key: key);

  _buildList(ComandaModel model) {
    return ListView.builder(
      itemCount: model.itens!.length,
      itemBuilder: (context, index) {
        final item = model.itens![index];
        return ListTile(
          title: Text(
            item.nome,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Text(
            'R\$ ${item.cpValor.toStringAsFixed(2)}',
            style: AppTextStyles.textBlack,
          ),
        );
      },
    );
  }

  _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Container(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {},
          child: Text(
            'Encerrar',
            style: AppTextStyles.buttonTextWhite,
          ),
        ),
      ),
    );
  }

  _buildTotal(ComandaModel model) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Total: ',
            style: AppTextStyles.textBlack,
          ),
          Text(
            'R\$ ${model.total.toStringAsFixed(2)}',
            style: AppTextStyles.textBlack,
          ),
        ],
      ),
    );
  }

  _buildBody(ComandaModel model) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: _buildList(model),
        ),
        Expanded(
          flex: 1,
          child: _buildTotal(model),
        ),
        _buildButton(),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildError() {
    return Center(
      child: Text(
        'Houve erro ao buscar consumo!',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Produtos | Mesa ${numeroMesa.toString().padLeft(2, '0')}',
          style: AppTextStyles.buttonTextBlack,
        ),
      ),
      body: FutureBuilder<ComandaModel>(
        future: repository.fetchComanda(numeroMesa),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final comanda = snapshot.data!;
            return _buildBody(comanda);
          }

          if (snapshot.hasError) {
            return _buildError();
          }

          return _buildLoading();
        },
      ),
    );
  }
}
