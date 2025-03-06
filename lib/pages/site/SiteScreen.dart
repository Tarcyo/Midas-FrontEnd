import 'package:flutter/material.dart';
import 'package:midas/pages/RegisterSite/RegisterSite.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'siteCard.dart'; // Widget para exibir o site
import 'package:midas/constants.dart';
import 'package:provider/provider.dart';

class SiteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserDataProvider>(context);

    // Criando lista de sites a partir dos dados
    final List<Map<String, String>> sites = [];
    for (final i in p.sites) {
      sites.add(
        {'code': i['id'], 'name': i['name'], 'url': i['url']},
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor, // ✅ Mantendo o fundo refinado
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Meus Sites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 1.2,
            fontFamily: 'Roboto',
          ),
        ),
        elevation: 6.0, // ✅ Sombra suave para efeito elegante
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: sites.isEmpty
              ? Center( // Centralizando o conteúdo (ícone e mensagens)
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center, // Centralizando o conteúdo
                    children: [
                      Icon(Icons.language, size: 80, color: Colors.black), // Ícone agora preto
                      const SizedBox(height: 16),
                      Text(
                        'Nenhum site encontrado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Cor da mensagem em preto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Adicione um novo site clicando no botão abaixo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Cor da mensagem em preto
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: sites.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SiteCard(
                          id: sites[index]['code'] ?? "",
                          name: sites[index]['name'] ?? "",
                          url: sites[index]['url'] ?? "",
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "2", // Adicione um identificador único
        backgroundColor: mainColor,
        icon: const Icon(Icons.add, size: 28, color: Colors.white),
        label: const Text(
          "Novo site",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder: (context, animation, _, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              pageBuilder: (_, __, ___) => RegisterSiteScreen(),
            ),
          );
        },
      ),
    );
  }
}
