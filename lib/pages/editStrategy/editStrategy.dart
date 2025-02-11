import 'package:flutter/material.dart';
import 'package:midas/model/token.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/reusableWidgets/URLList.dart';
import 'package:midas/services/strategy/createstrategy.dart';
import 'package:provider/provider.dart';
import '../../reusableWidgets/insertCamp.dart';

import '../../reusableWidgets/roundedAddButtom.dart';
import '../../reusableWidgets/roundedButtom.dart';

import 'package:midas/constants.dart';

class EditStrategy extends StatefulWidget {
  final dynamic _data;
  EditStrategy(this._data);
  @override
  State<EditStrategy> createState() => _EditStrategyState();
}
class _EditStrategyState extends State<EditStrategy> {

  @override
  void initState() {
    // TODO: implement initState
    nomeController.text=widget._data['name'];
    super.initState();
  }
  final TextEditingController nomeController = TextEditingController();

  final List<Token> _urls = [];
  final List<Token> _tokens = [];
  Token? _selectedCommoditie;

  @override
  Widget build(BuildContext context) {
    final List<Token> commodities = [];
    for (final i in Provider.of<UserDataProvider>(context).commodities) {
      commodities.add(Token(id: i['id'], token: i['name']));
    }
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          TextButton.icon(
                            onPressed: () => Navigator.pop(context),
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
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 650,
                          child: Card(
                            color: mainColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: mainColor, width: 10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Criar Estratégia',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome da estratégia',
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
                                      SizedBox(height: 5),
                                      TokenSelector(
                                        tokens: commodities,
                                        onTokenSelected: (value) {
                                          setState(() {
                                            _selectedCommoditie = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tokens',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UrlList(
                                            strings: _tokens,
                                          ),
                                          SizedBox(width: 15),
                                          RoundedAddButton(
                                            onPressed: () async {
                                              // Exemplo
                                              final List<Token> tokenList = [];
                                              for (final i in Provider.of<
                                                          UserDataProvider>(
                                                      context,
                                                      listen: false)
                                                  .tokens) {
                                                print("Tentando adicionar " +
                                                    i.toString());
                                                tokenList.add(
                                                  Token(
                                                      id: i['id'],
                                                      token: i['token']),
                                                );
                                              }

                                              // Chama o pop-up e aguarda o retorno dos tokens selecionados
                                              final selectedTokens =
                                                  await showDialog<List<Token>>(
                                                context: context,
                                                builder: (context) =>
                                                    TokenSelectionPopup(
                                                        tokens: tokenList),
                                              );

                                              // Faça algo com os tokens selecionados (por exemplo, exibir em um SnackBar)
                                              if (selectedTokens != null &&
                                                  selectedTokens.isNotEmpty) {
                                                setState(() {
                                                  _tokens
                                                      .addAll(selectedTokens);
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Tokens selecionados: ${selectedTokens.map((t) => t.token).join(', ')}"),
                                                  ),
                                                );
                                              } else if (selectedTokens !=
                                                      null &&
                                                  selectedTokens.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          "Nenhum token selecionado.")),
                                                );
                                              }
                                            },
                                            text: "Novo",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Urls',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UrlList(
                                            strings: _urls,
                                          ),
                                          SizedBox(width: 15),
                                          RoundedAddButton(
                                            onPressed: () async {
                                              // Exemplo
                                              final List<Token> tokenList = [];
                                              for (final i in Provider.of<
                                                          UserDataProvider>(
                                                      context,
                                                      listen: false)
                                                  .sites) {
                                                print("Tentando adicionar " +
                                                    i.toString());
                                                tokenList.add(
                                                  Token(
                                                      id: i['id'],
                                                      token: i['name']),
                                                );
                                              }

                                              final selectedTokens =
                                                  await showDialog<List<Token>>(
                                                context: context,
                                                builder: (context) =>
                                                    TokenSelectionPopup(
                                                        tokens: tokenList),
                                              );

                                              // Faça algo com os tokens selecionados (por exemplo, exibir em um SnackBar)
                                              if (selectedTokens != null &&
                                                  selectedTokens.isNotEmpty) {
                                                setState(() {
                                                  _urls.addAll(selectedTokens);
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Tokens selecionados: ${selectedTokens.map((t) => t.token).join(', ')}"),
                                                  ),
                                                );
                                              } else if (selectedTokens !=
                                                      null &&
                                                  selectedTokens.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          "Nenhum token selecionado.")),
                                                );
                                              }
                                            },
                                            text: "Novo",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RoundedButton(
                                        onPressed: () async {
                                          List<dynamic> tokens = [];
                                          List<dynamic> urls = [];
                                          for (final i in _urls) {
                                            urls.add(i.id);
                                          }
                                          for (final i in _tokens) {
                                            tokens.add(i.id);
                                          }
                                          await createStrategy(
                                              name: nomeController.text,
                                              commodityId:
                                                  _selectedCommoditie!.id,
                                              userId: Provider.of<AuthProvider>(
                                                      context,listen: false)
                                                  .id,
                                              sitesIds: urls,
                                              tokensIds: tokens,
                                              auth: Provider.of<AuthProvider>(
                                                      context,listen: false)
                                                  .token);
                                        },
                                        text: "Salvar",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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

class TokenSelectorDialog extends StatelessWidget {
  final List<Token> tokens;

  const TokenSelectorDialog({Key? key, required this.tokens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selecione um Token"),
      content: Container(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: tokens.map((token) {
            return ListTile(
              title: Text(token.token),
              onTap: () {
                Navigator.of(context).pop(token);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TokenSelector extends StatefulWidget {
  final List<Token> tokens;
  final ValueChanged<Token?> onTokenSelected;

  const TokenSelector({
    Key? key,
    required this.tokens,
    required this.onTokenSelected,
  }) : super(key: key);

  @override
  _TokenSelectorState createState() => _TokenSelectorState();
}

class _TokenSelectorState extends State<TokenSelector> {
  Token? selectedToken;

  void _showTokenDialog() async {
    final Token? result = await showDialog<Token>(
      context: context,
      builder: (BuildContext context) =>
          TokenSelectorDialog(tokens: widget.tokens),
    );

    if (result != null) {
      setState(() {
        selectedToken = result;
      });
      widget.onTokenSelected(result); // Chama a função de callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Commoditie',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: _showTokenDialog,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedToken?.token ?? "Selecione a Commoditie",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Classe do pop-up
class TokenSelectionPopup extends StatefulWidget {
  final List<Token> tokens;

  const TokenSelectionPopup({Key? key, required this.tokens}) : super(key: key);

  @override
  _TokenSelectionPopupState createState() => _TokenSelectionPopupState();
}

class _TokenSelectionPopupState extends State<TokenSelectionPopup> {
  // Lista para controlar quais tokens foram selecionados (usando os ids)
  final List<String> selectedTokenIds = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Selecione os Tokens",
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tokens.length,
          itemBuilder: (context, index) {
            final tokenItem = widget.tokens[index];
            final isSelected = selectedTokenIds.contains(tokenItem.id);
            return CheckboxListTile(
              title: Text(tokenItem.token),
              value: isSelected,
              activeColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedTokenIds.add(tokenItem.id);
                  } else {
                    selectedTokenIds.remove(tokenItem.id);
                  }
                });
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Envia null se o usuário cancelar
            Navigator.of(context).pop(null);
          },
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Filtra os tokens selecionados e retorna-os
            final selectedTokens = widget.tokens
                .where((token) => selectedTokenIds.contains(token.id))
                .toList();
            Navigator.of(context).pop(selectedTokens);
          },
          child: const Text("Ok"),
        ),
      ],
    );
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

class RemoveURLDialog extends StatelessWidget {
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
            color: Colors.white, // Definindo a cor da borda como azul
            width: 4.0, // Ajustando a largura da borda conforme necessário
          ),
        ),
        constraints: BoxConstraints(
            maxWidth: 320, // Definindo o tamanho máximo do Container
            minWidth: 100, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
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
                      color: Colors.white,
                      size: 30,
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
