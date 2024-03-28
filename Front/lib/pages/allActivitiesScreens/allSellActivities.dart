import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product card.dart';

class AllSellActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Venda')),
      ),
      body: Container(
        color: secondaryColor, // Define a cor de fundo como verde
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                    SizedBox(width: 10),
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
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                    SizedBox(width: 10),
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
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                    SizedBox(width: 10),
                    ProductCard(
                      productName: "CCMU24",
                      textColor: Colors.black,
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductCard(
                      productName: "CCMU24",
                      textColor: Colors.black,
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ProductCard(
                      productName: "CCMU24",
                      textColor: Colors.black,
                      price: "R\$ 129.28",
                      backgroundColor: Colors.white,
                      color: mainColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
