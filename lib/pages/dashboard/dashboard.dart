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
import 'package:midas/reusableWidgets/alertWidget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer? _timer;

  Color alertColor = Colors.blue;
  IconData alertIcon = Icons.pending;
  String alertText = "Nenhum alerta sobre sua estratégia";

  List<String> _newsTitles = [];
  List<dynamic> _urls = [];
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (mounted) {
        fetchNews();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
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

   /*   const String jsonData = '''
{
    "data": [
        {
            "description": "Caso isso não aconteça, presidente afirmou que deve caber ao Supremo Tribunal Federal deliberar sobre a questão\\nO post Lula pede regulamentação das redes sociais no Congresso apareceu primeiro em Olhar Digital.",
            "publishedAt": "06/02/2025",
            "title": "Lula pede regulamentação das redes sociais no Congresso",
            "url": "https://olhardigital.com.br/2025/02/06/internet-e-redes-sociais/lula-pede-regulamentacao-das-redes-sociais-no-congresso/",
            "urlToImage": "https://olhardigital.com.br/wp-content/uploads/2024/09/redes-sociais.jpg"
        },
        {
            "description": "A regulamentação das redes sociais é tratada como muito importante pelo presidente Luiz Inácio Lula da Silva. Saiba tudo sobre o tema\\nO post O que é a regulamentação das redes sociais? apareceu primeiro em Olhar Digital.",
            "publishedAt": "12/02/2025",
            "title": "O que é a regulamentação das redes sociais?",
            "url": "https://olhardigital.com.br/2025/02/12/internet-e-redes-sociais/o-que-e-a-regulamentacao-das-redes-sociais/",
            "urlToImage": "https://img.odcdn.com.br/wp-content/uploads/2025/02/Regulamentao-das-redes-sociais.png"
        },
        {
            "description": "O ex-presidente Jair Bolsonaro declarou usar chip hormonal para melhorar desempenho sexual. Entenda o que é a reposição de testosterona\\nO post Chip hormonal: o que é e como funciona o tratamento feito por Bolsonaro apareceu primeiro em Olhar Digital.",
            "publishedAt": "02/03/2025",
            "title": "Chip hormonal: o que é e como funciona o tratamento feito por Bolsonaro",
            "url": "https://olhardigital.com.br/2025/03/01/medicina-e-saude/chip-hormonal-o-que-e-e-como-funciona-o-tratamento-feito-por-bolsonaro/",
            "urlToImage": "https://img.odcdn.com.br/wp-content/uploads/2025/01/Bolsonaro-1-1.jpg"
        },
        {
            "description": "Entre implicados estão ex-presidente Jair Bolsonaro; ex-ministro e ex-vice na chapa de Bolsonaro, general Braga Netto; e ex-ajudante de ordens Mauro Cid.",
            "publishedAt": "19/02/2025",
            "title": "Veja quem são os 34 denunciados pela PGR por suposta tentativa de golpe de Estado",
            "url": "https://www.bbc.com/portuguese/articles/czrng030730o",
            "urlToImage": "https://ichef.bbci.co.uk/news/1024/branded_portuguese/139d/live/3b5eb7e0-eeb1-11ef-9a8e-416411b7ae51.jpg"
        },
        {
            "description": "Segundo a PGR, uma organização criminosa foi criada e era liderada pelo ex-presidente.",
            "publishedAt": "20/02/2025",
            "title": "Bolsonaro denunciado: ex-presidente pode ser preso?",
            "url": "https://www.bbc.com/portuguese/articles/cgj542l3d03o",
            "urlToImage": "https://ichef.bbci.co.uk/news/1024/branded_portuguese/6430/live/d17f1010-ef67-11ef-bd1b-d536627785f2.jpg"
        },
        {
            "description": "Casa Branca vai renegociar os prêmios previstos no programa CHIPS and Science Act, criado pela gestão Joe Biden\\nO post Guerra dos Chips: Trump pode mudar programa dos EUA apareceu primeiro em Olhar Digital.",
            "publishedAt": "14/02/2025",
            "title": "Guerra dos Chips: Trump pode mudar programa dos EUA",
            "url": "https://olhardigital.com.br/2025/02/14/pro/guerra-dos-chips-trump-pode-mudar-programa-dos-eua/",
            "urlToImage": "https://olhardigital.com.br/wp-content/uploads/2025/02/shutterstock_2566586537-1-scaled.jpg"
        },
        {
            "description": "Presidente dos EUA afirma que governo Biden perseguiu membros da igreja, citando manifestações antiaborto; Críticos falam em ameaça à liberdade religiosa",
            "publishedAt": "07/02/2025",
            "title": "Trump anuncia criação de força-tarefa para combater ‘viés anticristão’",
            "url": "https://veja.abril.com.br/mundo/trump-anuncia-criacao-de-forca-tarefa-para-combater-vies-anticristao",
            "urlToImage": "https://veja.abril.com.br/wp-content/uploads/2025/02/000_36X84VG.jpg?quality=70&strip=info&crop=1&resize=1080,565"
        }
    ],
    "feeling_data": {
        "mean_score": 0.9631587266921997,
        "most_common_label": "NEGATIVE"
    }
}''';
*/
      final map=json.decode(response.body);
      final data = map['data'];

      final feel = map['feeling_data'];

      if (feel['mean_score'] > 0.79) {
        if (feel['most_common_label'] == 'NEGATIVE') {
          alertColor = Colors.red;
          alertIcon = Icons.sell;
          alertText = "Momento ideal de venda!";
        } else {
          alertColor = mainColor;
          alertIcon = Icons.storefront_rounded;
          alertText = "Momento ideal de compra!";
        }
      } else {
        alertColor = Colors.blue;
        alertIcon = Icons.pending;
        alertText = "Nenhum alerta sobre sua estratégia no momento";
      }

      //   final data = json.decode(response.body)['data'];

      List<String> titles = [];

      List<String> urls = [];

      List<String> images = [];
      for (final i in data) {
        titles.add(i['title']);
        urls.add(i['url']);
        images.add(i['urlToImage']);
      }

      // if (response.statusCode == 200) {
      setState(() {
        _newsTitles = titles;
        _urls = urls;
        _images = images;
      });
      //   } else {
      //     print("Erro ao buscar notícias: ${response.statusCode}");
      //   }
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
                  _buildTitleWithBackground("PAINEL DE ALERTA"),

                  SizedBox(
                      height:
                          30), // Aumentei o espaço entre o título e o conteúdo

                  Center(
                    child: BigCardWidget(
                      baseColor: alertColor,
                      icon: alertIcon,
                      text: alertText,
                    ),
                  ),

                  SizedBox(height: 30),
                  // Título "Notícias" com fundo colorido
                  _buildTitleWithBackground("NOTÍCIAS"),

                  SizedBox(height: 10),
                  _buildNewsSection(),

                  SizedBox(height: 50),

                  // Título "Gráfico de Ativos" com fundo colorido
                  _buildTitleWithBackground("GRÁFICO DE ATIVOS"),

                  SizedBox(height: 10),
                  _buildGraphSection(),
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
