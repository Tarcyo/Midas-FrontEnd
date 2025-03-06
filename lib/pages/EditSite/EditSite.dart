import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/site/getSite.dart';
import 'package:midas/services/site/updateSite.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/authProvider.dart';
import '../../reusableWidgets/roundedButtom.dart';
import '../../reusableWidgets/insertCamp.dart';

class EditSiteScreen extends StatefulWidget {
  final String nome;
  final String url;
  final String id;
  const EditSiteScreen(
      {Key? key, required this.id, required this.nome, required this.url})
      : super(key: key);

  @override
  State<EditSiteScreen> createState() => _EditSiteScreenState();
}

class _EditSiteScreenState extends State<EditSiteScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nomeController.text = widget.nome;
    urlController.text=widget.url;
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
                                        'Editar Site',
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
                                        'Nome do site',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      RoundedTextField(
                                          controller: nomeController),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'URL',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      RoundedTextField(
                                          controller: urlController),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: RoundedButton(
                                          onPressed: () async {

                                            
                                            final p = Provider.of<AuthProvider>(
                                                context,
                                                listen: false);

                                            await updateSite(
                                                siteId: widget.id,
                                                userId: p.id,
                                                name: nomeController.text,
                                                urlAddress: urlController.text,
                                                token: p.token);
                                            final sites = await getUserSites(
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
                                                .sites = sites['sites'];
                                           Navigator.pop(context);
                                          },
                                          text: "Salvar",
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

  String getFirstPart(String input) {
    // Verifica se a string contém um ponto
    if (input.contains('.')) {
      // Divide a string no ponto e retorna a primeira parte
      return input.split('.').first;
    } else {
      // Se não houver ponto, retorna a string inteira
      return input;
    }
  }
}

class RemoveURlDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            color: Colors.white, // Definindo a cor da borda como branco
            width: 4.0, // Ajustando a largura da borda conforme necessário
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 300, // Definindo o tamanho máximo do Container
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
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir o site?',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    SizedBox(width: 5), // Espaçamento entre texto e ícone
                    Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
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

class AddURLDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

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
          Icons.link,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Digite a URL do novo site',
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
                    fontSize: 18, // Definindo a cor do texto como branco
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Definindo a cor do texto como branco
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
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

class AddTokenDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            color: Colors.white, // Definindo a cor da borda como branco
            width: 4.0, // Ajustando a largura da borda conforme necessário
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 350, // Ajustando o tamanho máximo do Container
          minWidth: 150, // Definindo um tamanho mínimo opcional
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
                  Navigator.of(context).pop(_newUrlController.text);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    SizedBox(width: 5), // Espaçamento entre o texto e o ícone
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
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
