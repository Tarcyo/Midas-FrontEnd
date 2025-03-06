import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/pages/editCommoditie/editCommoditie.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/commodity/deleteCommoditie.dart';
import 'package:midas/services/commodity/getComodity.dart';
import 'package:provider/provider.dart';

class CommoditieCard extends StatelessWidget {
  final String code;
  final String name;
  final String id;

  CommoditieCard({required this.code, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
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
          // Ícone e Informações da Commodity
          Row(
            children: [
              Icon(Icons.storefront, color: mainColor, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Botões de Ação
          Row(
            children: [
              _actionButton(
                icon: Icons.edit,
                color: mainColor,
                onTap: () => _editCommodity(context),
              ),
              _actionButton(
                icon: Icons.delete,
                color: Colors.redAccent,
                onTap: () => _confirmDelete(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Botão de ação reutilizável
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

  void _editCommodity(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return EditCommoditieScreen(
            codigo: code,
            nome: name,
            id: id,
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
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
                  "Excluir Commodity?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Tem certeza que deseja excluir esta commodity?",
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
        final auth = Provider.of<AuthProvider>(context, listen: false);
        final data = Provider.of<UserDataProvider>(context, listen: false);
        print("Estou tentando deletar o id:" + id);
        await deleteCommodity(id, auth.token);
        final commodities = await getCommodities(auth.id, auth.token);
        data.commodities = commodities['commodities'];
        Navigator.of(context).pop(isConfirm);
      },
      style: TextButton.styleFrom(
        foregroundColor: color,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
