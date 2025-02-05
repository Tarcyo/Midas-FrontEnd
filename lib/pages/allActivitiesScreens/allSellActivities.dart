import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product card.dart';

class AllSellActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obter o tamanho da tela usando MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Definir tamanhos responsivos com base no tamanho da tela
    //final double cardWidth = screenWidth * 0.4; // Largura dos cards
    final double cardSpacing = screenWidth * 0.02; // Espaçamento entre os cards
    final double topPadding = screenHeight * 0.05; // Espaçamento superior da coluna

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Venda', style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: secondaryColor,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: topPadding),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: cardSpacing,
                runSpacing: cardSpacing,
                children: [
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}