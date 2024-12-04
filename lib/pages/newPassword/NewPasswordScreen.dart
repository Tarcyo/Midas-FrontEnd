import 'package:flutter/material.dart';
import '../../reusableWidgets/roundedButtom.dart';
import '../../reusableWidgets/insertCampPassword.dart';

Color mainColor = Color(0xFF00C2A0);

class NewPasswordScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        child: Stack(
          children: [
            // Botão Voltar no canto superior esquerdo
            Positioned(
              top: 40,
              left: 16,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: Text(
                  'Voltar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            // Conteúdo principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 240,
                    width: 240,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/logoMidas.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Card(
                      color: mainColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64),
                        side: BorderSide(color: Colors.white, width: 10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Nova Senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            RoundedTextFieldPassword(
                              controller: newPasswordController,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Confirmar Senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            RoundedTextFieldPassword(
                              controller: confirmPasswordController,
                            ),
                            SizedBox(height: 30),
                            RoundedButton(
                              onPressed: () {
                                // Adicione aqui a lógica de redefinição de senha
                              },
                              text: "Confirmar",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}