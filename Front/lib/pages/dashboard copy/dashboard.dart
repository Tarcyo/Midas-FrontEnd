import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/fixedCamp.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 35, top: 20,right: 40), // Adiciona um padding
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Painel de sugestão",
                  style: TextStyle(fontSize: 20, color: mainColor),
                ),
                const SizedBox(height: 20), // Adiciona um espaço entre o texto e o FixedCamp
                FixedCamp(
                  text: "Comprar",
                  color: mainColor,
                  icon: Icons.alarm,
                ),
                            SizedBox(height: 10), // Adiciona um espaço entre o texto e o FixedCamp

              ],
            ),
            
          ],
        ),
      ),
    );
  }
}