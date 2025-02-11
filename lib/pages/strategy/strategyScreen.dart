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

    final listaWidget = strategies.isNotEmpty
        ? strategies.map((i) => StrategyCard(
              commodityName: i['name'],
              price1Week: "+2",
              price24Hours: "-3",
              price6Minutes: "+2",
              price3Minutes: "-1",
              price1Minute: "+1",
              data: i,
            )).toList()
        : [
            Expanded(
              child: Center(
                child: Text(
                  "Nenhuma estratégia encontrada",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ];

    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nova Estratégia',
                      style: TextStyle(
                        color: Color(0xFF00C2A0),
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  Duration(milliseconds: 1200),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return RegisterStrategyScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: mainColor,
                          size: 33,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listaWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
