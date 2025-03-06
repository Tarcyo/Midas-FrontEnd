import 'package:flutter/material.dart';
import '../../reusableWidgets/insertCamp.dart';
import '../../reusableWidgets/halfInsertCampPassword.dart';
import '../../reusableWidgets/halfInsertCamp.dart';
import '../../reusableWidgets/roundedButtom.dart';
import 'package:midas/constants.dart';
import 'package:midas/services/user/userRegister.dart';

class RegisterUser extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      "Voltar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 170,
                          width: 170,
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
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 450,
                          height:
                              540, // Aumentei a altura para acomodar mais campos
                          child: Card(
                            color: mainColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(
                                color: Colors.white,
                                width: 10,
                              ),
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
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      RoundedTextField(
                                          controller: emailController),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  // Campo de Nome

                                  SizedBox(height: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nome',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          HalfroundedTextField(
                                              controller: firstNameController),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      // Campo de Sobrenome
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sobrenome',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          HalfroundedTextField(
                                              controller: lastNameController),
                                        ],
                                      ),
                                      Text(
                                        'Telefone',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextField(
                                          controller: phoneController),
                                      SizedBox(height: 5),
                                      Text(
                                        'Senha',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextFieldPassword(
                                          controller: passwordController),
                                      SizedBox(height: 5),
                                      Text(
                                        'Confirmar senha',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextFieldPassword(
                                          controller:
                                              confirmPasswordController),
                                      SizedBox(height: 15),
                                      Center(
                                        child: RoundedButton(
                                          onPressed: () async {
                                            await _validateAndSubmit(context);
                                          },
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
                      SizedBox(
                        width: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateAndSubmit(BuildContext context) async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showAlertDialog(
          context, "Erro", "Todos os campos devem ser preenchidos.");
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showAlertDialog(context, "Erro", "Email inválido.");
    } else if (!RegExp(r'^\d{11}$').hasMatch(phone)) {
      _showAlertDialog(context, "Erro",
          "O número de telefone deve conter exatamente 11 dígitos.");
    } else if (password != confirmPassword) {
      _showAlertDialog(context, "Erro", "As senhas não coincidem.");
    } else {
      dynamic registrou = await registerUser(firstName, lastName,
          emailController.text, phoneController.text, passwordController.text);

      if (registrou == true) {
        _showAlertDialog(context, "Sucesso!", "O usuário foi registrado!");
      } else {
        _showAlertDialog(context, "Erro!", registrou);
      }
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: mainColor, width: 5),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Fechar o diálogo
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (value) {
        Navigator.of(context).pop(true); // Fechar o diálogo
      }
    });
  }
}
