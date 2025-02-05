import 'package:flutter/material.dart';
import 'strategyCard.dart';
import '../RegisterStrategy/RegisterStrategy.dart';
import 'package:midas/constants.dart';

class StrategyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final strategies = clienteProvider.cliente!.strategies;

    final listaWidget = [];
    listaWidget.add(StrategyCard(
      commodityName: "",
      price1Week: "+2",
      price24Hours: "-3",
      price6Minutes: "+2",
      price3Minutes: "-1",
      price1Minute: "+1",
      data: "11/11/2020",
    ));
    // for (final i in strategies) {
    //   listaWidget.add(CommoditieCard(
    //      commodityName: i.data['commodity']['name'],
    //      price1Week: "+2",
    //    price24Hours: "-3",
    //     price6Minutes: "+2",
    //     price3Minutes: "-1",
    //     price1Minute: "+1",
    //   data: i.data,)
    //    );
    //  }

    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Center(
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
                            // Navegue para a RegisterScreen quando o botão for pressionado
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
              ...listaWidget
            ],
          ),
        ),
      ),
    );
  }
}
