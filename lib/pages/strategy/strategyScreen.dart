import 'package:flutter/material.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'strategyCard.dart';
import '../RegisterStrategy/RegisterStrategy.dart';
import 'package:midas/constants.dart';
class StrategyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strategies = Provider.of<UserDataProvider>(context).estrategias;

    return Scaffold(
      backgroundColor: secondaryColor, // ✅ Mantendo o fundo com secondaryColor
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Minhas Estratégias',
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
          child: strategies.isEmpty
              ? Center( // Centralizando todo o conteúdo
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centralizando verticalmente
                    crossAxisAlignment: CrossAxisAlignment.center, // Centralizando horizontalmente
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 80,
                        color: Colors.black.withOpacity(0.6), // Ícone em preto com opacidade
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma estratégia encontrada!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Cor preta para o texto
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Crie uma nova estratégia clicando no botão abaixo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Cor preta para o texto
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: strategies.length,
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
                        child: StrategyCard(
                          commodityName:
                              strategies[index]['name'] ?? "Sem Nome",
                          data: strategies[index],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "1", // Adicione um identificador único
        backgroundColor: mainColor,
        icon: const Icon(Icons.add, size: 28, color: Colors.white),
        label: const Text(
          "Nova Estratégia",
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
              pageBuilder: (_, __, ___) => RegisterStrategyScreen(),
            ),
          );
        },
      ),
    );
  }
}
