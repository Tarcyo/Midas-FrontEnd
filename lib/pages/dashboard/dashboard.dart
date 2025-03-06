import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:midas/constants.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/reusableWidgets/product card.dart';
import 'package:midas/pages/allActivitiesScreens/allBuyActicities.dart';
import 'package:midas/pages/allActivitiesScreens/allSellActivities.dart';
import 'package:midas/reusableWidgets/fixedCamp.dart';
import 'package:midas/reusableWidgets/newsCard.dart';
import 'package:midas/services/strategy/getActiveStrategy.dart';
import 'graphic.dart';
import 'package:midas/pages/expandedGraphic/expandedGraphic.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer? _timer;
  List<String> _newsTitles = [];
  List<dynamic> _urls = [];
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    fetchNews(); // Faz a primeira requisição
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      // Verifica se o widget ainda está montado antes de chamar fetchNews()
      if (mounted) {
        fetchNews(); // Requisição periódica a cada 15 segundos
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar o timer ao descartar o widget
    super.dispose();
  }

  String _separaTokens(Map<String, dynamic>? activeStrategy) {
    String tokens = "";
    if (activeStrategy == null) {
      return tokens;
    }
    for (int i = 0; i < activeStrategy!['tokens'].length; i++) {
      tokens = tokens + activeStrategy!['tokens'][i]['token'];
      if (i == activeStrategy!['tokens'].length - 1) {
        return tokens;
      }
      tokens = tokens + ",";
    }
    return tokens;
  }

  Future<void> fetchNews() async {
    final activeStrategy = await getActiveStrategy(
      Provider.of<AuthProvider>(context, listen: false).id,
      Provider.of<AuthProvider>(context, listen: false).token,
    );
    String tokens = "";

    print("A estratégia atualmente ativa é: " + activeStrategy.toString());

    tokens = _separaTokens(activeStrategy);

    print("OS tokens são: " + tokens);

    final String apiUrl = "http://localhost:3000/search-news?tokens=" + tokens;

    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
        },
        Uri.parse(apiUrl),
      );

      final data = json.decode(response.body)['data'];

      List<String> titles = [];

      List<String> urls = [];

      List<String> images = [];
      for (final i in data) {
        titles.add(i['title']);
        urls.add(i['url']);
        images.add(i['urlToImage']);
      }

      if (response.statusCode == 200) {
        setState(() {
          _newsTitles = titles;
          _urls = urls;
          _images = images;
        });
      } else {
        print("Erro ao buscar notícias: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao conectar à API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor:
            mainColor, // Cor de fundo do AppBar igual à tela de Grupos
        title: const Text(
          'DASHBOARD ', // Título igual ao da tela de Grupos
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontFamily: 'Roboto',
          ),
        ),
        elevation: 6.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centraliza todos os itens
                children: [
                  // Título principal com fundo colorido
                  _buildTitleWithBackground("PAINEL DE SUGESTÃO"),

                  SizedBox(
                      height:
                          30), // Aumentei o espaço entre o título e o conteúdo

                  // Seção de "Comprar"
                  FixedCamp(
                    text: "Comprar",
                    color: mainColor,
                    icon: Icons.notifications,
                  ),
                  SizedBox(height: 15),
                  _buildProductSection(
                      "Comprar", mainColor, AllBuyActivitiesScreen()),

                  SizedBox(height: 40),

                  // Seção de "Vender"
                  FixedCamp(
                    text: "Vender",
                    color: Colors.red[900]!,
                    icon: Icons.warning,
                  ),
                  SizedBox(height: 15),
                  _buildProductSection(
                      "Vender", Colors.red[900]!, AllSellActivitiesScreen()),

                  SizedBox(height: 40),

                  // Título "Ativos Sugeridos" com fundo colorido
                  _buildTitleWithBackground("ATIVOS SUGERIDOS"),

                  SizedBox(height: 15),
                  _buildSuggestedAssets(),

                  SizedBox(height: 50),

                  // Título "Gráfico de Ativos" com fundo colorido
                  _buildTitleWithBackground("GRÁFICO DE ATIVOS"),

                  SizedBox(height: 10),
                  _buildGraphSection(),

                  SizedBox(height: 30),

                  // Título "Notícias" com fundo colorido
                  _buildTitleWithBackground("NOTÍCIAS"),

                  SizedBox(height: 10),
                  _buildNewsSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Método para criar título com fundo colorido
  Widget _buildTitleWithBackground(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: mainColor, // Fundo colorido
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildProductSection(String type, Color color, Widget screen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centraliza os cards
      children: [
        ProductCard(
          productName: "CCMU24",
          textColor: Colors.black,
          price: "R\$ 129.28",
          backgroundColor: Colors.white,
          color: color,
        ),
        SizedBox(width: 10),
        ProductCard(
          productName: "CCMU24",
          textColor: Colors.black,
          price: "R\$ 129.90",
          color: color,
          backgroundColor: Colors.white,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1200),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return screen;
                },
              ),
            );
          },
          icon: Icon(Icons.pending),
          iconSize: 40,
        ),
      ],
    );
  }

  Widget _buildSuggestedAssets() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centraliza os cards de ativos sugeridos
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
    );
  }

  Widget _buildGraphSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o gráfico
      children: [
        DropdownButton<String>(
          value: "FUT CCM",
          items: [
            DropdownMenuItem<String>(value: "Dias", child: Text('Dias')),
            DropdownMenuItem<String>(value: "Semanas", child: Text('Semanas')),
            DropdownMenuItem<String>(value: "FUT CCM", child: Text('FUT CCM')),
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
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ExpandedGraphic();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    ScrollController _scrollController = ScrollController();

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      trackVisibility: true,
      interactive: true, // Permite interação com o usuário
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12), // Espaço para o Scrollbar
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _newsTitles.isEmpty
                ? [
                    Center(child: CircularProgressIndicator()),
                  ]
                : List.generate(_newsTitles.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: NewsCard(
                        _newsTitles[index],
                        _images[index],
                        _urls[index],
                      ),
                    );
                  }),
          ),
        ),
      ),
    );
  }
}
