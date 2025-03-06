import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/pages/editToken/EditToken.dart';
import 'package:midas/providers/authProvider.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:midas/services/token/deleToken.dart';
import 'package:midas/services/token/getTokens.dart';
import 'package:provider/provider.dart';

class TokenCard extends StatelessWidget {
  final String name;
  final String id;

  TokenCard({required this.id, required this.name});

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
          // Ícone e Nome do Token
          Row(
            children: [
              Icon(Icons.vpn_key, color: mainColor, size: 32),
              SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // Botões de ação
          Row(
            children: [
              _actionButton(
                icon: Icons.edit,
                color: mainColor,
                onTap: () => _editToken(context),
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

  // Botão de ação personalizado
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

  void _editToken(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return EditTokenScreen(id: id, nome: name);
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
                  "Excluir Token?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Tem certeza que deseja excluir este token?",
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
        await deleteToken(
            id, Provider.of<AuthProvider>(context, listen: false).token);
        final tokens = await getTokens(
            Provider.of<AuthProvider>(context, listen: false).id,
            Provider.of<AuthProvider>(context, listen: false).token);

        Provider.of<UserDataProvider>(context, listen: false).tokens =
            tokens['tokens'];
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
