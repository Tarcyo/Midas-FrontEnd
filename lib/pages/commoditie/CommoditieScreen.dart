import 'package:flutter/material.dart';
import 'package:midas/pages/RegisterCommoditie/RegisterCommoditie.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'commoditieCard.dart';
import 'package:midas/constants.dart';
import 'package:provider/provider.dart';

class CommoditieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserDataProvider>(context);

    // Criando a lista de commodities
    final List<Map<String, String>> commodities =
        p.commodities.map<Map<String, String>>((i) {
      return {
        'code': i['code'] ?? '',
        'name': i['name'] ?? '',
        'id': i['id'] ?? "",
      };
    }).toList();

    return Scaffold(
      backgroundColor: secondaryColor, // ✅ Mantendo o fundo com secondaryColor
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Minhas Commodities',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 1.2,
            fontFamily: 'Roboto',
          ),
        ),
        elevation: 6.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: commodities.isEmpty
              ? Center(
                  // Usando o widget Center para garantir que o conteúdo fique centralizado
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          size: 80, color: Colors.black), // Ícone preto
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma commodity encontrada!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Texto em preto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Adicione uma nova commodity clicando no botão abaixo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Texto em preto
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: commodities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Destaque para os cards no fundo escuro
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CommoditieCard(
                          code: commodities[index]['code'] ?? "Sem Código",
                          name: commodities[index]['name'] ?? "Sem Nome",
                          id: commodities[index]['id'] ?? "",
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "5", // Adicione um identificador único
        backgroundColor: mainColor,
        icon: const Icon(Icons.add, size: 28, color: Colors.white),
        label: const Text(
          "Nova Commoditie",
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
              pageBuilder: (_, __, ___) => RegisterCommoditieScreen(),
            ),
          );
        },
      ),
    );
  }
}
