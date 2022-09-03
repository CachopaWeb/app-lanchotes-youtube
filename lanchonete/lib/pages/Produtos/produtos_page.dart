import 'package:flutter/material.dart';
import 'package:lanchonete/Componentes/produto_widget.dart';
import 'package:lanchonete/models/produto_model.dart';
import 'package:lanchonete/repositories/produtos_repository.dart';

import '../../core/app_textStyles.dart';

class ProdutosPage extends StatelessWidget {
  final repository = ProdutosRepository();
  final String nomeCategoria;
  final int codigoMesa;
  final int codigoCategoria;

  ProdutosPage({
    Key? key,
    required this.nomeCategoria,
    required this.codigoMesa,
    required this.codigoCategoria,
  }) : super(key: key);

  Widget _buildBody(List<ProdutosModel> listaProdutos) {
    return ListView(
      children: listaProdutos
          .map(
            (model) => ProdutoWidget(
              produtoModel: model,
            ),
          )
          .toList(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Text(
        'Erro ao carregar produtos!',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${this.nomeCategoria}| Mesa ${this.codigoMesa.toString().padLeft(2, '0')}',
          style: AppTextStyles.buttonTextBlack,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProdutosModel>>(
        future: repository.fetchProdutosPorCategoria(codigoCategoria),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return _buildBody(snapshot.data!);
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
