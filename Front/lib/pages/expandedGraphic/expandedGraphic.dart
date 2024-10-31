import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'graphic.dart';

class ExpandedGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 35, top: 20, right: 40),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Definindo o scroll na direção horizontal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                children: [
                  SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color:  mainColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    icon: Icon(
                      Icons.arrow_back,
                      color:  mainColor,
                      size: 20,
                    ),
                    label: Text(
                      "Voltar",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          DropdownButton<String>(
                            value: "FUT CCM",
                            items: [
                              DropdownMenuItem<String>(
                                value: "Dias",
                                child: Text('Dias'),
                              ),
                              DropdownMenuItem<String>(
                                value: "Semanas",
                                child: Text('Semanas'),
                              ),
                              DropdownMenuItem<String>(
                                value: "FUT CCM",
                                child: Text('FUT CCM'),
                              ),
                            ],
                            onChanged: (String? value) {
                              // Handle dropdown changes here
                              print('Selected: $value');
                            },
                          ),
                          GestureDetector(
                            child: Graphic(),
                            onTap: () {
                              // Navegue para a RegisterScreen quando o botão for pressionado
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 1200),
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
                                    return ExpandedGraphic();
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 400),
                              DropdownButton<int>(
                                value: 6,
                                items: List.generate(10, (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text((index + 1).toString()),
                                  );
                                }),
                                onChanged: (value) {
                                  // Handle dropdown changes here
                                },
                              ),
                              SizedBox(width: 20),
                              DropdownButton<String>(
                                value: "Meses",
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "Dias",
                                    child: Text('Dias'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Semanas",
                                    child: Text('Semanas'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Meses",
                                    child: Text('Meses'),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  // Handle dropdown changes here
                                  print('Selected: $value');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}