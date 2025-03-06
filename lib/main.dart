import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Importe o pacote provider
import 'pages/login/login.dart';
import 'providers/authProvider.dart'; // Importe o AuthProvider
import 'providers/userDataProvider.dart'; // Importe o AuthProvider
import 'constants.dart';
import './services/socket/socketService.dart';

void main() {
  final socketService =
      SocketService(AuthProvider()); 

  runApp(App(socketService: socketService));
}

class App extends StatelessWidget {
  final SocketService socketService;

  const App({super.key, required this.socketService});

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
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SocketService(AuthProvider())),
        // Provider(create: (context) => SocketService(AuthProvider())),
      ],
      child: MaterialApp(
        title: 'M.I.D.A.S',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: mainColor,
          fontFamily: "Quicksand",
        ),
        home: LoginScreen(), // Sua tela de login
      ),
    );
  }
}
