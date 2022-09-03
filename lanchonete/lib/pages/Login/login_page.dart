import 'package:flutter/material.dart';
import 'package:lanchonete/core/app_colors.dart';
import 'package:lanchonete/core/app_imagens.dart';
import 'package:lanchonete/core/app_textStyles.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Image.asset(AppImagens.logo),
            ),
            TextFormField(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 39,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Text('Acessar', style: AppTextStyles.buttonTextBlack),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
