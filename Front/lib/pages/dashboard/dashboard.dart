import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product card.dart';
import 'package:midas/pages/allActivitiesScreens/allBuyActicities.dart';
import 'package:midas/pages/allActivitiesScreens/allSellActivities.dart';
import 'package:midas/reusableWidgets/fixedCamp.dart';
import 'package:midas/reusableWidgets/newsCard.dart';
import 'graphic.dart';
import 'package:midas/pages/expandedGraphic/expandedGraphic.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer? _timer;
  List<String> _newsTitles = [];
  List<dynamic> _urls = [];
  List<dynamic> _images = [];
  final String apiUrl = "http://localhost:5001/get-news";

  @override
  void initState() {
    super.initState();
    fetchNews(); // Faz a primeira requisição
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchNews(); // Requisição periódica a cada 30 segundos
    });
  }

  Future<void> fetchNews() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            ["Rain"]), // Tópicos de exemplo
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          print(response.body.toString());
          _newsTitles = List<String>.from(data['titles']);
          _urls = List<dynamic>.from(data['url']);
          _images = List<dynamic>.from(data['urlToImage']);
        });
      } else {
        print("Erro ao buscar notícias: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao conectar à API: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o timer ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 35, top: 20, right: 40),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Painel de sugestão",
                    style: TextStyle(fontSize: 25, color: mainColor),
                  ),
                  const SizedBox(height: 20),
                  FixedCamp(
                      text: "Comprar",
                      color: mainColor,
                      icon: Icons.notifications),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ProductCard(
                        productName: "CCMU24",
                        textColor: Colors.black,
                        price: "R\$ 129.28",
                        backgroundColor: Colors.white,
                        color: mainColor,
                      ),
                      SizedBox(width: 10),
                      ProductCard(
                        productName: "CCMU24",
                        textColor: Colors.black,
                        price: "R\$ 129.90",
                        color: mainColor,
                        backgroundColor: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return AllBuyActivitiesScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.pending),
                        iconSize: 40,
                      )
                    ],
                  ),
                  SizedBox(height: 80),
                  FixedCamp(
                      text: "Vender",
                      color: Colors.red[900]!,
                      icon: Icons.warning),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ProductCard(
                        productName: "OPF ICF",
                        price: "R\$ 129.28",
                        color: Colors.red[900]!,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      ProductCard(
                        productName: "FUT CCM",
                        price: "R\$ 129.90",
                        textColor: Colors.black,
                        color: Colors.red[900]!,
                        backgroundColor: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return AllSellActivitiesScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.pending),
                        iconSize: 40,
                      )
                    ],
                  ),
                  SizedBox(height: 150),
                  Text(
                    "Ativos Sugeridos",
                    style: TextStyle(fontSize: 25, color: mainColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ProductCard(
                        productName: "Açúcar",
                        price: "+36%",
                        backgroundColor: mainColor,
                        textColor: Colors.white,
                        color: Colors.transparent,
                      ),
                      SizedBox(width: 20),
                      ProductCard(
                        productName: "Álcool",
                        price: "+6%",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        backgroundColor: mainColor,
                      ),
                      SizedBox(width: 30),
                      ProductCard(
                        productName: "Dólar",
                        price: "-9%",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        backgroundColor: Colors.red[900]!,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: "FUT CCM",
                        items: [
                          DropdownMenuItem<String>(
                            value: "Dias",
                            child: Text('Dias'),
                          ),
                          DropdownMenuItem<String>(
                            value: "Semanas",
                            child: Text('Semanas'),
                          ),
                          DropdownMenuItem<String>(
                            value: "FUT CCM",
                            child: Text('FUT CCM'),
                          ),
                        ],
                        onChanged: (String? value) {
                          print('Selected: $value');
                        },
                      ),
                      GestureDetector(
                        child: Graphic(),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ExpandedGraphic();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 400),
                          DropdownButton<int>(
                            value: 6,
                            items: List.generate(10, (index) {
                              return DropdownMenuItem<int>(
                                value: index + 1,
                                child: Text((index + 1).toString()),
                              );
                            }),
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 20),
                          DropdownButton<String>(
                            value: "Meses",
                            items: [
                              DropdownMenuItem<String>(
                                value: "Dias",
                                child: Text('Dias'),
                              ),
                              DropdownMenuItem<String>(
                                value: "Semanas",
                                child: Text('Semanas'),
                              ),
                              DropdownMenuItem<String>(
                                value: "Meses",
                                child: Text('Meses'),
                              ),
                            ],
                            onChanged: (String? value) {
                              print('Selected: $value');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: _newsTitles.isEmpty
                        ? [
                            Center(child: CircularProgressIndicator()),
                          ]
                        : _newsTitles.take(3).map((title) {
                            int index = _newsTitles.indexOf(title);
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: NewsCard(
                                title,
                                _images[index],
                                _urls[index],
                              ),
                            );
                          }).toList(),
                  ),
                  SizedBox(height: 30)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
