import 'package:flutter/material.dart';
import 'package:midas/pages/RegisterSite/RegisterSite.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'siteCard.dart'; // Presumindo que você tem um widget para exibir a commodity
import 'package:midas/constants.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/clienteProvider.dart';
import 'package:midas/pages/EditSite/EditSite.dart';

class SiteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserDataProvider>(context);

    final List<Map<String, String>> commodities = [];
    for (final i in p.sites) {
      commodities.add(
        {'code': i['id'], 'name': i['name']},
      );
      print("Exemplo de site:" + i.toString());
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
                        'Novo Site',
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
                                return RegisterSiteScreen();
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
                child: commodities.isEmpty
                    ? Center(
                        child: Text(
                          "Nenhum site encontrado",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            (commodities.length / 4).ceil(), // Número de linhas
                        itemBuilder: (context, rowIndex) {
                          // Calcula os índices dos commodities para a linha atual
                          int startIndex = rowIndex * 4;
                          int endIndex = (startIndex + 4 < commodities.length)
                              ? startIndex + 4
                              : commodities.length;

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(endIndex - startIndex,
                                    (index) {
                                  int commodityIndex = startIndex + index;
                                  return SiteCard(
                                    id: commodities[commodityIndex]['code'] ??
                                        "",
                                    name: commodities[commodityIndex]['name'] ??
                                        "",
                                  );
                                }),
                              ),
                              const SizedBox(height: 20), // Espaço entre linhas
                            ],
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
