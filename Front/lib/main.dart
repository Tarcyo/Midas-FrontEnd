import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Importe o pacote provider
import 'pages/login/login.dart';
import 'providers/clienteProvider.dart'; // Importe o ClienteProvider
import 'providers/authProvider.dart'; // Importe o AuthProvider
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    // Envolvendo o MaterialApp com MultiProvider para incluir o AuthProvider e ClienteProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClienteProvider()), // Cria o provider de cliente
        ChangeNotifierProvider(create: (context) => AuthProvider()), // Cria o provider de autenticação
      ],
      child: MaterialApp(
        title: 'M.I.D.A.S',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          fontFamily: "Quicksand",
        ),
        home: LoginScreen(), // Sua tela de login
      ),
    );
  }
}