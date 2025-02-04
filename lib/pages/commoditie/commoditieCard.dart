import 'package:flutter/material.dart';
import 'package:midas/pages/editCommoditie/editCommoditie.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/commodity/deleteCommoditie.dart';
import 'package:midas/services/commodity/getComodity.dart';
import 'package:provider/provider.dart';

class CommoditieCard extends StatelessWidget {
  final String code; // Código da commodity
  final String name; // Nome da commodity
  final String id;
  CommoditieCard({required this.code, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290, // Largura fixa do cartão
      height: 100, // Altura fixa do cartão
      child: Card(
        elevation: 4, // Sombra do cartão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(height: 4), // E
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
                    onPressed: () async {
                      // Ação para excluir
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return RemoveTokenDialog();
                        },
                      );
                      if (result == true) {
                        final auth = Provider.of<AuthProvider>(context,listen: false);
                        final data = Provider.of<UserDataProvider>(context,listen: false);
                        print("Estou tentando deletar o id:"+id);
                        await deleteCommodity(id, auth.token);
                        final commodities =
                            await getCommodities(auth.id, auth.token);
                        data.commodities=commodities['commodities'];
                      }
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
                            return EditCommoditieScreen(
                              codigo: code,
                              nome: name,
                              id: id,
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
          Icons.delete,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir a Commodity?',
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
