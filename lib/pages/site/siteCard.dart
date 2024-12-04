import 'package:flutter/material.dart';
import 'package:midas/pages/EditSite/EditSite.dart';
class SiteCard extends StatelessWidget {
  final String name; // Nome do site

  SiteCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220, // Largura reduzida do cartão
      height: 80,  // Altura reduzida do cartão
      child: Card(
        elevation: 3, // Sombra do cartão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32), // Bordas arredondadas
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Espaçamento interno ajustado
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaço entre nome e ícones
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 25, // Tamanho da fonte para o nome
                    color: Colors.grey[800], // Cor do texto
                  ),
                  overflow: TextOverflow.ellipsis, // Adiciona elipses se o texto ultrapassar o limite
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30, // Ícone menor para deletar
                    ),
                    onPressed: () {
                      // Ação para deletar
                      print('Deletar $name');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30, // Ícone menor para editar
                    ),
                    onPressed: () {
                      // Ação para editar
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 600),
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
                            return EditSiteScreen();
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