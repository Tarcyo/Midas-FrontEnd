import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/fixedCamp.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Configurações',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView( // Permite rolar a tela se necessário
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSettingRow("Notificações", Icons.notifications, 'Compra e Venda'),
                const SizedBox(height: 25),

                buildSettingRow("Período de análise", Icons.analytics, '3 dias'),
                const SizedBox(height: 25),

                buildSettingRow("Período das notícias", Icons.newspaper, '1 Semana'),
                const SizedBox(height: 25),

                buildSettingRow("Sites de notícias", Icons.language, 'Minha Lista'),
                const SizedBox(height: 25),

                buildSettingRow("Notificação dos grupos", Icons.group, 'Ativado'),
                const SizedBox(height: 25),

                buildSettingRow("Adição em grupo", Icons.add, 'Permitir'),
                const SizedBox(height: 35),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Restaurar padrões');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Borda arredondada
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                      backgroundColor: mainColor, // Cor de fundo do botão
                      shadowColor: Colors.black.withOpacity(0.2),
                      elevation: 8.0,
                    ),
                    child: Text(
                      'Restaurar Padrões',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para gerar uma linha de configuração com FixedCamp e Dropdown
  Widget buildSettingRow(String text, IconData icon, String dropdownValue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Sombra suave
          ),
        ],
      ),
      child: Row(
        children: [
          FixedCamp(
            text: text,
            color: mainColor,
            icon: icon,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                print(newValue);
              },
              items: <String>[
                'Compra e Venda', '2', '3', '3 dias', '1 Semana', 'Minha Lista', 'Ativado', 'Permitir'
              ] 
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              iconEnabledColor: mainColor, // Cor do ícone
              dropdownColor: Colors.white, // Cor de fundo do dropdown
            ),
          ),
        ],
      ),
    );
  }
}
