import 'package:flutter/material.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/group/deleteGroup.dart';
import 'package:midas/services/group/getGroup.dart';
import 'package:midas/services/group/updateGroup.dart';
import 'package:provider/provider.dart';
import '../../reusableWidgets/insertCamp.dart';

import '../../reusableWidgets/roundedButtom.dart';

import 'package:midas/constants.dart';

class EditGroup extends StatefulWidget {
  final String id;
  final String nome;

  EditGroup({required this.id, required this.nome});

  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  final TextEditingController nomeController = TextEditingController();

  @override
  void initState() {
    nomeController.text = widget.nome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide(color: mainColor, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            icon: Icon(Icons.arrow_back,
                                color: mainColor, size: 20),
                            label: Text(
                              "Voltar",
                              style: TextStyle(color: mainColor, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: 600,
                          child: Card(
                            color: mainColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: mainColor, width: 10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Editar Grupo',
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome do grupo',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      RoundedTextField(
                                          controller: nomeController),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: RoundedButton(
                                          onPressed: () async {
                                            print("O id do grupo:" +
                                                widget.id.toString());
                                            await updateGroup(
                                                widget.id,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .id,
                                                nomeController.text,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .token);
                                            final grupos = await getGroups(
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .id,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .token);

                                            Provider.of<UserDataProvider>(
                                                    context,
                                                    listen: false)
                                                .groups = grupos['groups'];
                                            Navigator.of(context).pop();
                                          },
                                          text: "Salvar",
                                        ),
                                      ),
                                      Center(
                                        child: RoundedButton(
                                          onPressed: () async {
                                            print("O id do grupo:" +
                                                widget.id.toString());

                                            await deleteGroup(
                                                widget.id,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .id,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .token);
                                            final grupos = await getGroups(
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .id,
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .token);

                                            Provider.of<UserDataProvider>(
                                                    context,
                                                    listen: false)
                                                .groups = grupos['groups'];
                                            Navigator.of(context).pop();
                                          },
                                          text: "Excluir",
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveURlDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
        constraints: BoxConstraints(
            maxWidth: 350, minWidth: 150, maxHeight: 250, minHeight: 250),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir o site?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
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
                        color: Colors.white,
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

class AddUserDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
        constraints: BoxConstraints(
            maxWidth: 350, minWidth: 150, maxHeight: 250, minHeight: 250),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Digite o código do usuário',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        RoundedTextField(controller: _newUrlController),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_newUrlController.text);
                },
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Adicionar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  18 // Definindo a cor do texto como branco
                              ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
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

class RemoveTokenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white, // Definindo a cor da borda como azul
            width: 4.0,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 350,
          minWidth: 150,
          maxHeight: 250,
        ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
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
          'Tem certeza que deseja sair excluir o token?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
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
                        color: Colors.white,
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

class AddTokenDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
        constraints: BoxConstraints(
            maxWidth: 350, // Definindo o tamanho máximo do Container
            minWidth: 150, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ), // Reduzindo o tamanho máximo do Container
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
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
          'Digite o novo Token',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
        SizedBox(height: 20),
        RoundedTextField(controller: _newUrlController),
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
                      color: Colors.white,
                      fontSize: 18 // Definindo a cor do texto como branco
                      ),
                ),
              ),
            ),
            SizedBox(width: 5), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_newUrlController.text);
                },
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Adicionar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  18 // Definindo a cor do texto como branco
                              // Definindo a cor do texto como branco
                              ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
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

class DeleteConfirmationDialog extends StatelessWidget {
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
            maxWidth: 350, // Definindo o tamanho máximo do Container
            minWidth: 150, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ), // Reduzindo o tamanho máximo do Container
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja  excluir o Grupo?',
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
            SizedBox(width: 10), // Adicionando um espaçamento entre os botões
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
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.white,
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
