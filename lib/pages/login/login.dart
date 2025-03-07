import 'package:flutter/material.dart';
import 'package:midas/pages/registerUser/registerUser.dart';
import 'package:midas/services/group/getGroup.dart';
import 'package:midas/services/resetPassword/resetPassword.dart';
import 'package:midas/services/site/getSite.dart';
import 'package:midas/services/strategy/fetchStrategy.dart';
import 'package:midas/services/strategy/getActiveStrategy.dart';
import 'package:midas/services/token/getTokens.dart';
import '../../reusableWidgets/insertCamp.dart';
import 'package:midas/services/auth/login.dart';
import '../../reusableWidgets/insertCampPassword.dart';
import 'package:midas/providers/authProvider.dart';
import '../../reusableWidgets/roundedButtom.dart';
import '../../reusableWidgets/clicableWhiteText.dart';
import '../../homeTabBar.dart';
import 'package:provider/provider.dart';
import 'package:midas/pages/resetPassword/resetPassword.dart';
import 'package:midas/constants.dart';
import 'package:midas/services/commodity/getComodity.dart';
import 'package:midas/providers/userDataProvider.dart';

class LoginScreen extends StatelessWidget {
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
                height: 230, // ajuste conforme necessário
                width: 230, // ajuste conforme necessário
                child: Padding(
                  padding: EdgeInsets.all(4), // ajuste conforme necessário para o tamanho da borda
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
                width: 300, // Definindo largura máxima para o Card
                height: 330, // Definindo altura máxima para o Card
                child: Card(
                  color: mainColor,
                  elevation: 5, // Elevação para adicionar sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(64),
                    side: BorderSide(color: Colors.white, width: 10), // Borda branca
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20, height: 20),
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
                            SizedBox(height: 3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(height: 10, width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextFieldPassword(controller: passwordController),
                            SizedBox(height: 10, width: 10),
                            Center(
                              child: RoundedButton(
                                onPressed: () async {
                                  final result = await loginUser(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  if (result == null) {
                                    _showAlertDialog(
                                      context,
                                      "Erro",
                                      "Verifique os seus dados e tente novamente",
                                    );
                                    return;
                                  }

                                  print("os resultados são:" + result.toString());

                                  Provider.of<AuthProvider>(context, listen: false)
                                      .setEmail(result["user_email"]);
                                  Provider.of<AuthProvider>(context, listen: false)
                                      .setToken(result["token"]);
                                  Provider.of<AuthProvider>(context, listen: false)
                                      .setId(result["user_id"]);

                                  final commoodity = await getCommodities(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  final sites = await getUserSites(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  Provider.of<UserDataProvider>(context, listen: false).sites = sites['sites'];
                                  Provider.of<UserDataProvider>(context, listen: false).commodities = commoodity['commodities'];

                                  final tokens = await getTokens(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  Provider.of<UserDataProvider>(context, listen: false).tokens = tokens['tokens'];

                                  final estrategias = await getStrategies(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  Provider.of<UserDataProvider>(context, listen: false).estrategias = estrategias['strategies'];

                                  final grupos = await getGroups(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  Provider.of<UserDataProvider>(context, listen: false).groups = grupos['groups'];

                                  final activeStrategy = await getActiveStrategy(
                                    Provider.of<AuthProvider>(context, listen: false).id,
                                    Provider.of<AuthProvider>(context, listen: false).token,
                                  );

                                  Provider.of<UserDataProvider>(context, listen: false).activeStrategy = activeStrategy;

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 300),
                                      transitionsBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation) {
                                        return HomePage();
                                      },
                                    ),
                                  );
                                },
                                text: "Entrar",
                              ),
                            ),
                            SizedBox(width: 10, height: 10),
                            Center(
                              child: Column(
                                children: [
                                  ClickableWhiteText(
                                    onPressed: () async{




                                      if (emailController.text.isEmpty) {
                                        _showAlertDialog(
                                          context,
                                          "Atenção",
                                          "Por favor, informe seu e-mail para recuperar a senha",
                                        );
                                      } else {

                                     final String codigo= await enviarCodigoRecuperacao(emailController.text);

                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration(milliseconds: 300),
                                            transitionsBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secondaryAnimation,
                                                Widget child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secondaryAnimation) {
                                              return ResetPasswordScreen(codigoRecuperacao: codigo,email: emailController.text,);
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    text: "Não consegue fazer Login?",
                                  ),
                                  SizedBox(width: 5, height: 5),
                                  ClickableWhiteText(
                                    onPressed: () {
                                      // Navegue para a RegisterScreen quando o botão for pressionado
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: Duration(milliseconds: 300),
                                          transitionsBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double> secondaryAnimation,
                                              Widget child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double> secondaryAnimation) {
                                            return RegisterUser();
                                          },
                                        ),
                                      );
                                    },
                                    text: "Não possui conta?",
                                  ),
                                ],
                              ),
                            )
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
                    Navigator.of(context).pop(); // Fechar o diálogo
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
