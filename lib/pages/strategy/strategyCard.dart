import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/model/token.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/commodity/fetchCommotie.dart';
import 'package:midas/services/strategy/activateStrategy.dart';
import 'package:midas/services/strategy/deleteStrategy.dart';
import 'package:midas/services/strategy/fetchStrategy.dart';
import 'package:midas/services/strategy/getActiveStrategy.dart';
import 'package:midas/services/strategy/getStratégies.dart';
import 'package:provider/provider.dart';
import '../editStrategy/editStrategy.dart';

class StrategyCard extends StatelessWidget {
  final String commodityName;
  final dynamic data;

  StrategyCard({required this.commodityName, required this.data});

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.green;
    IconData icon = Icons.play_arrow;
    if (Provider.of<UserDataProvider>(context).actvatedStrategy == null) {
    } else {
      if (data['id'] ==
          Provider.of<UserDataProvider>(context).actvatedStrategy['id']) {
        buttonColor = Colors.red;
        icon = Icons.pause;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: mainColor, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commodityName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: mainColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _actionButton(
                  icon: icon,
                  color: buttonColor,
                  onTap: () async {
                    await _activateStrategy(context);
                  }),
              _actionButton(
                icon: Icons.edit,
                color: mainColor,
                onTap: () => _editStrategy(context),
              ),
              _actionButton(
                icon: Icons.delete,
                color: Colors.redAccent,
                onTap: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  void _editStrategy(BuildContext context) async {
    final strategyData = await fetchStrategy(
      data['id'],
      Provider.of<AuthProvider>(context, listen: false).token,
    );
    final commodityData = await fetchCommodity(
      strategyData['commodity_id'],
      Provider.of<AuthProvider>(context, listen: false).token,
    );
    final commodity = Token(
      id: commodityData['id'],
      token: commodityData['name'],
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return EditStrategy(strategyData, commodity);
        },
      ),
    );
  }

  Future<void> _activateStrategy(BuildContext context) async {
    await activateStrategy(
        data['id'],
        Provider.of<AuthProvider>(context, listen: false).id,
        Provider.of<AuthProvider>(context, listen: false).token);

    final activeStrategy = await getActiveStrategy(
      Provider.of<AuthProvider>(context, listen: false).id,
      Provider.of<AuthProvider>(context, listen: false).token,
    );

    Provider.of<UserDataProvider>(context, listen: false).activeStrategy =
        activeStrategy;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Estratégia ${data['name']} ativada!",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.teal.shade900,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.redAccent, size: 40),
                SizedBox(height: 10),
                Text(
                  "Excluir Estratégia?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Tem certeza que deseja excluir esta estratégia?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dialogButton(
                        context, "Cancelar", Colors.grey[700]!, false),
                    _dialogButton(context, "Deletar", Colors.redAccent, true),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogButton(
      BuildContext context, String text, Color color, bool isConfirm) {
    return TextButton(
      onPressed: () async {
        if (isConfirm) {
          await deleteStrategy(data['id'],
              Provider.of<AuthProvider>(context, listen: false).token);
          final estrategias = await getStrategies(
              Provider.of<AuthProvider>(context, listen: false).id,
              Provider.of<AuthProvider>(context, listen: false).token);

          Provider.of<UserDataProvider>(context, listen: false).estrategias =
              estrategias['strategies'];
        }
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        foregroundColor: color,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
