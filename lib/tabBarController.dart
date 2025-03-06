import 'package:flutter/material.dart';
import 'constants.dart';

class TabBarController extends StatefulWidget {
  final List<PersistentTabItem> items;

  const TabBarController({Key? key, required this.items}) : super(key: key);

  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late PageController _pageController;
  int _selectedTab = 0;
  bool _menuExpanded = true;

  void _toggleMenu() {
    setState(() {
      _menuExpanded = !_menuExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    _navigatorKeys =
        List.generate(widget.items.length, (_) => GlobalKey<NavigatorState>());
    _pageController = PageController(initialPage: _selectedTab);
  }

  Future<void> _onExit() async {
    dynamic exit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExitConfirmationDialog();
      },
    );

    if (exit == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = widget.items
        .asMap()
        .entries
        .map(
          (MapEntry<int, PersistentTabItem> entry) => GestureDetector(
            onTap: () {
              if (entry.key == _selectedTab) {
                _navigatorKeys[entry.key]
                    .currentState
                    ?.popUntil((route) => route.isFirst);
              } else {
                setState(() {
                  _selectedTab = entry.key;
                  _pageController.jumpToPage(entry.key);
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: entry.key == _selectedTab && _menuExpanded
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(160),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          entry.key != _selectedTab ? mainColor : Colors.white,
                    ),
                    child: Icon(
                      entry.value.icon,
                      size: 24,
                      color:
                          entry.key != _selectedTab ? Colors.white : mainColor,
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Visibility(
                      visible: _menuExpanded,
                      child: Text(
                        entry.value.title,
                        style: TextStyle(
                            color: entry.key == _selectedTab
                                ? mainColor
                                : Colors.white,
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
            width: _menuExpanded ? 200 : 80,
            color: mainColor,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...items,
                  GestureDetector(
                    onTap: _onExit,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(160),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Icon(
                              Icons.logout,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Visibility(
                              visible: _menuExpanded,
                              child: Text(
                                "Sair",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              children: List.generate(
                widget.items.length,
                (index) => Navigator(
                  key: _navigatorKeys[index],
                  onGenerateRoute: (routeSettings) {
                    return MaterialPageRoute(
                      builder: (context) => widget.items[index].tab,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem({
    required this.tab,
    this.navigatorkey,
    required this.title,
    required this.icon,
  });
}

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 4.0),
        ),
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.error, color: Colors.white, size: 50),
            SizedBox(height: 20),
            Text(
              'Tem certeza que deseja sair do aplicativo?',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child:
                        Text('Cancelar', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Sair', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
