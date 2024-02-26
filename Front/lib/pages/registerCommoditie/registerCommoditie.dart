import 'package:flutter/material.dart';
import '../../reusableWidgets/insertCamp.dart';
import '../../reusableWidgets/roundedDropdown.dart';
import '../../reusableWidgets/roundedButtom.dart';
import 'package:midas/constants.dart';

class RegisterCommoditie extends StatefulWidget {
  @override
  State<RegisterCommoditie> createState() => _RegisterCommoditieState();
}

class _RegisterCommoditieState extends State<RegisterCommoditie> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  TextEditingController _controller = TextEditingController();

  List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo a barra azul
      body: Container(
        // Definindo a cor de fundo
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 450, // Definindo largura máxima para o Card
                height: 487, // Definindo altura máxima para o Card
                child: Card(
                  color: mainColor,
                  elevation: 5, // Elevação para adicionar sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side:
                        BorderSide(color: mainColor, width: 10), // Borda branca
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nova comoditie',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Código',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'URL Site',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            Column(
                              children: [
                                RoundedDropdown(
                                  controller: _controller,
                                  options: _options,
                                  selectedOption: _selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption = newValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RoundedButton(
                                      onPressed: () => {},
                                      text: "Novo",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'Tokens',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            Column(
                              children: [
                                RoundedDropdown(
                                  controller: _controller,
                                  options: _options,
                                  selectedOption: _selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption = newValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RoundedButton(
                                      onPressed: () => {},
                                      text: "Novo",
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Text(
                              'Nome Estratégia',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: passwordController),
                            SizedBox(
                              height: 50,
                              width: 50,
                            ),

                            Center(
                              child: RoundedButton(
                                onPressed: () => {},
                                text: "Cadastrar",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
