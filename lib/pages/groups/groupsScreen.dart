import 'package:flutter/material.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'groupCard.dart';
import '../newGroup/newGroupScreen.dart';
import 'package:midas/constants.dart';

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaWidget = [];

    // Criando os widgets para exibição dos grupos
    for (final i in Provider.of<UserDataProvider>(context).groups) {
      listaWidget.add(
        GroupCard(
          gropuId: i['id'],
          groupName: i["name"],
          members: [],
        ),
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor, // Cor de fundo suavizada
      appBar: AppBar(
        backgroundColor: mainColor, // Fundo do AppBar com a cor principal
        title: const Text(
          'Meus Grupos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 1.2,
            fontFamily: 'Roboto',
          ),
        ),
        elevation: 6.0, // Sombra suave para o AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 40), // Espaçamento superior ajustado
              Expanded(
                child: listaWidget.isEmpty
                    ? Center( // Centralizando o conteúdo
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group_add,
                              size: 80,
                              color: Colors.black, // Ícone preto
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhum grupo encontrado',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black, // Mensagem em preto
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Adicione um novo grupo clicando no botão abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Mensagem em preto
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: listaWidget.map((widget) {
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
                                child: widget,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      // FloatingActionButton para adicionar grupo
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "3", // Adicione um identificador único
        backgroundColor: mainColor,
        icon: const Icon(Icons.add, size: 28, color: Colors.white),
        label: const Text(
          "Novo Grupo",
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
              pageBuilder: (_, __, ___) => NewGroup(),
            ),
          );
        },
      ),
    );
  }
}
