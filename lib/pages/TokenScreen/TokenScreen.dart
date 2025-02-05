import 'package:flutter/material.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'TokenCard.dart'; // Presumindo que você tem um widget para exibir a commodity
import 'package:midas/constants.dart';
import 'package:provider/provider.dart';

import 'package:midas/pages/RegisterToken/RegisterToken.dart';

class TokenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserDataProvider>(context);

    //

    final List<Map<String, String>> tokens = [];

    for (final i in p.tokens) {
      tokens.add(
        {'code': i['id'], 'name': i['token']},
      );
    }

    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50, width: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Novo Token',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(width: 2),
                      IconButton(
                        onPressed: () {
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
                                return RegisterToken();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: mainColor,
                          size: 33,
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: tokens.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum token encontrado',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            (tokens.length / 4).ceil(), // Número de linhas
                        itemBuilder: (context, rowIndex) {
                          int startIndex = rowIndex * 4;
                          int endIndex = (startIndex + 4 < tokens.length)
                              ? startIndex + 4
                              : tokens.length;

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(endIndex - startIndex,
                                    (index) {
                                  int commodityIndex = startIndex + index;
                                  return TokenCard(
                                    name: tokens[commodityIndex]['name'] ?? "",
                                    id: tokens[commodityIndex]['code'] ?? "",
                                  );
                                }),
                              ),
                              const SizedBox(height: 20), // Espaço entre linhas
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
