import 'package:flutter/material.dart';
import 'package:lanchonete/core/app_colors.dart';

import 'package:lanchonete/core/app_textStyles.dart';
import 'package:lanchonete/pages/Config/config_page.dart';
import 'package:lanchonete/pages/Itens/itens_page.dart';
import 'package:lanchonete/pages/Mesas/mesas_page.dart';

enum Paginas { inicio, mesas, itens, configuracao }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final _paginas = <Widget>[
    TelaInicial(),
    MesasPage(),
    ItensPage(),
    ConfigPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mesas | Comandas',
          style: AppTextStyles.buttonTextBlack,
        ),
      ),
      body: _paginas.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          _index = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_sharp), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.apps_sharp), label: 'Mesas'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Itens'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config.'),
        ],
      ),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 300,
        width: double.infinity,
        child: Column(children: [
          Text(
            'Comanda ou Mesa',
            style: AppTextStyles.textoGray,
          ),
          TextFormField(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(texto: 'Inserir Item'),
              CustomButton(texto: 'Ver Detalhes'),
            ],
          )
        ]),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String texto;

  const CustomButton({
    Key? key,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: 110,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
        ),
        onPressed: () {},
        child: Text(
          texto,
          style: AppTextStyles.buttonTextBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
