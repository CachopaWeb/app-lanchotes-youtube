import 'package:flutter/material.dart';
import 'package:lanchonete/core/app_colors.dart';

import 'package:lanchonete/core/app_textStyles.dart';

enum StatusMesa { ocupada, livre, fechamento }

Color statusToColor(StatusMesa value) {
  Color cor = AppColors.statusMesaLivre;
  switch (value) {
    case StatusMesa.livre:
      break;
    case StatusMesa.ocupada:
      cor = AppColors.statusMesaOcupada;
      break;
    case StatusMesa.fechamento:
      cor = AppColors.statusMesaFechamento;
      break;
  }
  return cor;
}

String statusToString(StatusMesa value) {
  String nome = 'Livre';
  switch (value) {
    case StatusMesa.livre:
      break;
    case StatusMesa.ocupada:
      nome = 'Ocupada';
      break;
    case StatusMesa.fechamento:
      nome = 'Fechamento';
      break;
  }
  return nome;
}

StatusMesa stringToStatus(String value) {
  StatusMesa status = StatusMesa.livre;
  switch (value) {
    case 'A':
      break;
    case 'O':
      status = StatusMesa.ocupada;
      break;
    case 'F':
      status = StatusMesa.fechamento;
      break;
  }
  return status;
}

class ItemWidget extends StatelessWidget {
  final StatusMesa status;
  final int index;
  final double valor;

  ItemWidget({
    Key? key,
    required this.status,
    required this.index,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == StatusMesa.livre) {
          Navigator.of(context).pushNamed('/categorias', arguments: index);
        } else {
          Navigator.of(context).pushNamed('/consumo', arguments: index);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: statusToColor(status),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(3.0, 3.0),
              color: Colors.black,
              blurRadius: 3.0,
            )
          ],
        ),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusToString(status),
              style: AppTextStyles.statusMesa,
            ),
            Text(
              '${index.toString().padLeft(2, '0')}',
              style: AppTextStyles.numeroMesa,
            ),
            Text(
              '${valor.toStringAsFixed(2)}',
              style: AppTextStyles.valorMesa,
            ),
          ],
        ),
      ),
    );
  }
}
