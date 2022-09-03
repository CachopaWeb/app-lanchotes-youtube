import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:lanchonete/models/produto_model.dart';
import 'package:lanchonete/repositories/produtos_repository.dart';

class ProdutoWidget extends StatelessWidget {
  final repository = ProdutosRepository();
  final contador = ValueNotifier<int>(0);
  final ProdutosModel produtoModel;

  ProdutoWidget({
    Key? key,
    required this.produtoModel,
  }) : super(key: key);

  Widget _buildSucessImagem(String base64) {
    return base64.isNotEmpty
        ? Image.memory(base64Decode(base64))
        : Center(
            child: Text('Sem Foto'),
          );
  }

  Widget _buildErrorImagem() {
    return Center(
      child: Text('Imagem não encontrada'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildImagemProduto(int codigo) {
    return FutureBuilder<String>(
      future: repository.fetchFotoProduto(codigo),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Container(
            width: 100,
            child: _buildSucessImagem(snapshot.data!),
          );
        }
        if (snapshot.hasError) {
          return _buildErrorImagem();
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildCardProduto() {
    return Card(
      elevation: 10,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImagemProduto(produtoModel.codigo),
            Column(
              children: [
                Container(
                  width: 150,
                  child: Center(
                    child: Text(
                      produtoModel.nome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'R\$ ${produtoModel.valor.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            _buildActions(),
            SizedBox(
              width: 2,
            )
          ],
        ),
      ),
    );
  }

  Column _buildActions() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            contador.value += 1;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            height: 30,
            width: 30,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        ValueListenableBuilder<int>(
            valueListenable: contador,
            builder: (context, value, child) {
              return Text('$value');
            }),
        GestureDetector(
          onTap: () {
            contador.value -= 1;
            if (contador.value < 0) {
              contador.value = 0;
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            height: 30,
            width: 30,
            child: Icon(Icons.remove, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCardProduto();
  }
}
