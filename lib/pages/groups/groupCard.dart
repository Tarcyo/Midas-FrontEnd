import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/pages/group/groupScreen.dart';
import 'package:midas/pages/editGroup/editGroup.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final String gropuId; // Mantendo o nome como no código original
  final List<Widget> members;

  GroupCard({
    required this.gropuId,
    required this.groupName,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ícone do grupo e informações
          Row(
            children: [
              CircleAvatar(
                backgroundColor: mainColor.withOpacity(0.15),
                radius: 28,
                child: Icon(Icons.group, color: mainColor, size: 30),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [mainColor, secondaryColor],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Ícones dos membros e ações
          Row(
            children: [
              Row(children: members),
              const SizedBox(width: 16),
              _actionButton(
                icon: Icons.chat,
                color: mainColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder: (context, animation, _, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      pageBuilder: (_, __, ___) => GroupScreen(groupName),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _actionButton(
                icon: Icons.edit,
                color: Colors.grey[700]!,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder: (context, animation, _, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      pageBuilder: (_, __, ___) => EditGroup(id: gropuId, nome: groupName),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Botão de ação reutilizável
  Widget _actionButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: onPressed,
      ),
    );
  }
}
