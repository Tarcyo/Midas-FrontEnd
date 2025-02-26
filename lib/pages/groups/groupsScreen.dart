import 'package:flutter/material.dart';
import 'package:midas/providers/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'groupCard.dart';
import '../newGroup/newGroupScreen.dart';
import 'package:midas/constants.dart';

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaWidget = [];

    for (final i in Provider.of<UserDataProvider>(context).groups) {
      listaWidget.add(
        GroupCard(
          gropuId: i['id'],
          groupName: i["name"],
          members: [],
          newMessages: 1,
        ),
      );
    }

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
                      'Novo Grupo',
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
                              return NewGroup();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: mainColor,
                        size: 33,
                      ),
                    ),
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
              child: listaWidget.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum grupo encontrado',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [...listaWidget],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
