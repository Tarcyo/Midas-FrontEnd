import 'package:flutter/material.dart';
import 'package:midas/pages/RegisterCommoditie/RegisterCommoditie.dart';
import 'commoditieCard.dart'; // Presumindo que você tem um widget para exibir a commodity
import 'package:midas/constants.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/clienteProvider.dart';

class CommoditieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clienteProvider = Provider.of<ClienteProvider>(context);
    
    // Aqui você deve obter suas commodities de algum lugar, usando a lógica do seu app.
    // Para o exemplo, vou criar uma lista fictícia de commodities.
    List<Map<String, String>> commodities = [
      {'code': 'SOY3', 'name': 'Soja'},
      {'code': 'WHEAT', 'name': 'Trigo'},
      {'code': 'CORN', 'name': 'Milho'},
      {'code': 'RICE', 'name': 'Arroz'},
      {'code': 'SUGAR', 'name': 'Açúcar'},
      {'code': 'COFFEE', 'name': 'Café'},
      {'code': 'COTTON', 'name': 'Algodão'},
      {'code': 'BARLEY', 'name': 'Cevada'},
      {'code': 'OATS', 'name': 'Aveia'},
      // Adicione mais commodities conforme necessário
    ];

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
                        'Nova Commoditie',
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
                                return RegisterCommoditieScreen();
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
                child: ListView.builder(
                  itemCount: (commodities.length / 4).ceil(), // Número de linhas
                  itemBuilder: (context, rowIndex) {
                    // Calcula os índices dos commodities para a linha atual
                    int startIndex = rowIndex * 4;
                    int endIndex = (startIndex + 4 < commodities.length) ? startIndex + 4 : commodities.length;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(endIndex - startIndex, (index) {
                            int commodityIndex = startIndex + index;
                            return CommoditieCard(
                              code: commodities[commodityIndex]['code'] ?? '',
                              name: commodities[commodityIndex]['name'] ?? '',
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