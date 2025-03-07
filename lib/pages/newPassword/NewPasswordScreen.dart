import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import '../../reusableWidgets/roundedButtom.dart';
import '../../reusableWidgets/insertCampPassword.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewPasswordScreen extends StatelessWidget {
  final String verificationToken;
  final String email;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  NewPasswordScreen({
    Key? key,
    required this.verificationToken,
    required this.email,
  }) : super(key: key);

  Future<void> changePassword(BuildContext context) async {
    final Uri url = Uri.parse('http://localhost:8080/auth/change-password?recoverToken=$verificationToken');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, dynamic> body = {
      'email': email,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Senha alterada com sucesso!')),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${jsonDecode(response.body)['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar com o servidor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        child: Stack(
          children: [
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
                              onPressed: () async {
                                await changePassword(context);
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
