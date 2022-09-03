import 'package:flutter/material.dart';
import 'package:lanchonete/core/app_colors.dart';
import 'package:lanchonete/models/produtos_arguments_model.dart';
import 'package:lanchonete/pages/Categorias/Categorias_page.dart';
import 'package:lanchonete/pages/Consumo/consumo_page.dart';
import 'package:lanchonete/pages/Home/home_page.dart';
import 'package:lanchonete/pages/Login/login_page.dart';
import 'package:lanchonete/pages/Produtos/produtos_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lachonete',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/categorias': (context) => CategoriasPage(
              numeroMesa: ModalRoute.of(context)!.settings.arguments as int,
            ),
        '/consumo': (context) => ConsumoPage(
              numeroMesa: ModalRoute.of(context)!.settings.arguments as int,
            ),
        '/produtos': (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as ProdutosArguments;
          return ProdutosPage(
            nomeCategoria: arguments.nomeCategoria,
            codigoMesa: arguments.codigoMesa,
            codigoCategoria: arguments.codigoCategoria,
          );
        },
      },
    );
  }
}
