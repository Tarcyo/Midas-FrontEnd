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
  bool _menuExpanded = false;

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
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(
                  vertical: 8), // Aumenta a distância vertical entre os botões
              decoration: BoxDecoration(
                color: entry.key == _selectedTab && _menuExpanded
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    180), // Define bordas arredondadas para o quadrado branco
              ),
              child: Row(
                children: [
                  Container(
                    width: 56, // Diminui o tamanho da bola branca
                    height: 56, // Diminui o tamanho da bola branca
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: entry.key != _selectedTab
                          ? mainColor
                          : Colors.white,
                    ),
                    child: Icon(
                      entry.value.icon,
                      size: 32, // Ajusta o tamanho do ícone
                      color: entry.key != _selectedTab
                          ? Colors.white
                          : mainColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Visibility(
                      visible: _menuExpanded,
                      child: Text(
                        entry.value.title,style: TextStyle(color: entry.key==_selectedTab ? mainColor :Colors.white, fontSize: 18),
                        overflow: TextOverflow
                            .ellipsis, // Define o comportamento de overflow
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKeys[_selectedTab].currentState?.canPop() ?? false) {
          _navigatorKeys[_selectedTab].currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 350), // Duração da animação
              width: _menuExpanded ? 250 : 100,
              color: mainColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: ()=> {
                      _toggleMenu()
                      
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(
                          vertical:
                              8), // Aumenta a distância vertical entre os botões
                      decoration: BoxDecoration(
                        color: 
                             Colors.transparent
                         ,
                        borderRadius: BorderRadius.circular(
                            180), // Define bordas arredondadas para o quadrado branco
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56, // Diminui o tamanho da bola branca
                            height: 56, // Diminui o tamanho da bola branca
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Icon(
                              Icons.menu,
                              size: 40, // Ajusta o tamanho do ícone
                              color: 
                                   Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Visibility(
                              visible: _menuExpanded,
                              child: Text(
                                style:TextStyle(color: Colors.white,fontSize: 25),
                                "Menu",
                                overflow: TextOverflow
                                    .ellipsis, // Define o comportamento de overflow
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...items,
                ],
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
