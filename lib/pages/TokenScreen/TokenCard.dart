import 'package:flutter/material.dart';
import 'package:midas/pages/EditToken/EditToken.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/token/deleToken.dart';
import 'package:midas/services/token/getTokens.dart';
import 'package:provider/provider.dart';

class TokenCard extends StatelessWidget {
  final String name;
  final String id;

  TokenCard({required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 80,
      child: Card(
        elevation: 3, // Sombra do cartão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32), // Bordas arredondadas
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8), // Espaçamento interno ajustado
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Espaço entre nome e ícones
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 25, // Tamanho da fonte para o nome
                    color: Colors.grey[800], // Cor do texto
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Adiciona elipses se o texto ultrapassar o limite
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
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return RemoveTokenDialog();
                        },
                      );

                      if (result != true) {
                        return;
                      }
                      print("tentando deletar o token:"+id);
                      await deleteToken(
                          id, Provider.of<AuthProvider>(context,listen: false).token);
                      final tokens = await getTokens(
                          Provider.of<AuthProvider>(context, listen: false).id,
                          Provider.of<AuthProvider>(context, listen: false)
                              .token);

                      Provider.of<UserDataProvider>(context, listen: false)
                          .tokens = tokens['tokens'];
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30, // Ícone menor para editar
                    ),
                    onPressed: () async {
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
                            return EditTokenScreen(
                              id: id,
                              nome: name,
                            );
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

class RemoveTokenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(180.0), // Ajustando o raio da borda do dialog
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0), // Definindo a cor de fundo como verde
          borderRadius: BorderRadius.circular(20), // Raio da borda do Container
          border: Border.all(
            // Adicionando uma borda ao redor do conteúdo
            color: Colors.white, // Definindo a cor da borda como azul
            width: 4.0, // Ajustando a largura da borda conforme necessário
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 320, // Ajustando o tamanho máximo do Container
          minWidth: 100, // Definindo um tamanho mínimo opcional
          maxHeight: 250, // Ajustando a altura máxima conforme necessário
          minHeight: 250, // Definindo uma altura mínima opcional
        ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.key,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir o token?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Alinhando os botões nos cantos opostos
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Definindo a cor do texto como branco
                  ),
                ),
              ),
            ),
            SizedBox(width: 8), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Row(
                  children: [
                    Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
