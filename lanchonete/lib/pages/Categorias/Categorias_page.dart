import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:lanchonete/core/app_textStyles.dart';
import 'package:lanchonete/models/categoria_model.dart';
import 'package:lanchonete/models/produtos_arguments_model.dart';
import 'package:lanchonete/repositories/categoria_repository.dart';

class CategoriasPage extends StatefulWidget {
  final int numeroMesa;

  CategoriasPage({
    Key? key,
    required this.numeroMesa,
  }) : super(key: key);

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final repository = CategoriaRepository();

  Widget _buildCard(String title, int id) {
    return GestureDetector(
      onTap: () {
        final arguments = ProdutosArguments(
          codigoCategoria: id,
          codigoMesa: widget.numeroMesa,
          nomeCategoria: title,
        );
        Navigator.of(context).pushNamed('/produtos', arguments: arguments);
      },
      child: Stack(
        children: [
          _buildImageCategory(id),
          Positioned(
            bottom: 35,
            left: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.tituloCategoria,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCategory(int id) {
    return FutureBuilder<String>(
      future: repository.getFotoCategoria(id),
      initialData: '',
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return _SuccessImage(snapshot.data!);
        }
        if (snapshot.hasError) {
          return _buildErrorFoto();
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildErrorFoto() {
    return Text('Erro ao buscar Foto da Categoria!');
  }

  Widget _SuccessImage(String base64) {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
        image: DecorationImage(
          image: MemoryImage(base64Decode(base64)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  GridView _buildSuccess(List<CategoriaModel> listaCategorias) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      children: listaCategorias
          .map(
            (model) => _buildCard(
              model.nome,
              model.codigo,
            ),
          )
          .toList(),
    );
  }

  _buildError() {
    return Center(
      child: Text(
        'Erro ao buscar categorias!',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<List<CategoriaModel>>(
        initialData: const [],
        future: repository.getCategoria(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return _buildSuccess(snapshot.data!);
          }

          if (snapshot.hasError) {
            return _buildError();
          }

          return _buildLoading();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categorias | Mesa ${widget.numeroMesa.toString().padLeft(2, '0')}',
          style: AppTextStyles.buttonTextBlack,
        ),
      ),
      body: _buildBody(),
    );
  }
}
