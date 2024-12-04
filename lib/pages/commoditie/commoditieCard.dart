import 'package:flutter/material.dart';
import 'package:midas/pages/editCommoditie/editCommoditie.dart';

class CommoditieCard extends StatelessWidget {
  final String code; // Código da commodity
  final String name; // Nome da commodity

  CommoditieCard({required this.code, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290, // Largura fixa do cartão
      height: 100, // Altura fixa do cartão
      child: Card(
        elevation: 4, // Sombra do cartão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32), // Bordas arredondadas
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Espaçamento interno
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // Distribui o espaço entre os widgets
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               //
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(
                      height: 4), // E
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: 25, // Tamanho da fonte para o código
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Cor do texto
                    ),
                  ),
                  const SizedBox(
                      height: 4), // Espaçamento entre o código e o nome
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20, // Tamanho da fonte para o nome
                      color: Colors.grey[700], // Cor do texto para o nome
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ), // Ícone de excluir
                    onPressed: () {
                      // Ação para excluir
                      print('Excluir $code');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30,
                    ), // Ícone de editar
                    onPressed: () {
                      // Ação para editar
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1200),
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
                            return EditCommoditieScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
