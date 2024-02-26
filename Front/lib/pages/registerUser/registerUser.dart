import 'package:flutter/material.dart';
import '../../reusableWidgets/insertCamp.dart';
import '../../reusableWidgets/halfInsertCampPassword.dart';
import '../../reusableWidgets/halfInsertCamp.dart';

import '../../reusableWidgets/roundedButtom.dart';

import 'package:midas/constants.dart';
class RegisterUser extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo a barra azul
      body: Container(
        // Definindo a cor de fundo
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 240, // ajuste conforme necessário
                width: 240, // ajuste conforme necessário
                child: Padding(
                  padding: EdgeInsets.all(
                    4, // ajuste conforme necessário para o tamanho da borda
                  ),
                  child: Container(
                    color: Colors.transparent, // torna o fundo transparente
                    child: Image.asset(
                      'assets/images/logoMidas.png', // substitua com o caminho correto da sua imagem
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 450, // Definindo largura máxima para o Card
                height: 395, // Definindo altura máxima para o Card
                child: Card(
                  color: mainColor,
                  elevation: 5, // Elevação para adicionar sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                        color: Colors.white, width: 10), // Borda branca
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Criar Conta',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome completo',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Telefone',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            HalfroundedTextField(
                                controller: passwordController),
                            SizedBox(
                              height: 5,
                              width: 5,
                            ),
                            Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            HalfroundedTextFieldPassword(
                                controller: passwordController),
                            SizedBox(
                              height: 5,
                              width: 5,
                            ),
                             Text(
                              'Confirmar senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            HalfroundedTextFieldPassword(
                                controller: passwordController),
                            SizedBox(
                              height: 15,
                              width: 15,
                            ),

                            Center(
                              child: RoundedButton(
                                onPressed: () => {},
                                text: "Cadastrar",
                              ),
                            ),
                         
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
