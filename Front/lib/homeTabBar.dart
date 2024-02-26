import 'package:flutter/material.dart';
import 'tabBarController.dart';

import 'pages/commoditie/commoditieScreen.dart';

import 'pages/dashboard/dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarController(
      items: [
     
        PersistentTabItem(
          title: 'Dashboard',
          tab: const DashboardScreenTab(),
          icon: Icons.home,
        ),
        PersistentTabItem(
          title: 'Commodities',
          tab: const CommoditieScreenTab(),
          icon: Icons.wallet,
        ),
        PersistentTabItem(
          title: 'Chat',
          tab: const DashboardScreenTab(),
          icon: Icons.chat,
        ),
        PersistentTabItem(
          title: 'Settings',
          tab: const DashboardScreenTab(),
          icon: Icons.settings,
        ),
      ],
    );
  }
}

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dashboard();
  }

  @override
  bool get wantKeepAlive => true;
}

class DashboardScreenTab extends StatefulWidget {
  const DashboardScreenTab({Key? key}) : super(key: key);

  @override
  _DashboardScreenTabState createState() => _DashboardScreenTabState();
}

class _DashboardScreenTabState extends State<DashboardScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dashboard();
  }

  @override
  bool get wantKeepAlive => true;
}

class LinkScreenTab extends StatefulWidget {
  const LinkScreenTab({Key? key}) : super(key: key);

  @override
  _LinkScreenTabState createState() => _LinkScreenTabState();
}

class _LinkScreenTabState extends State<LinkScreenTab>
    with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;
}

class CommoditieScreenTab extends StatefulWidget {
  const CommoditieScreenTab({Key? key}) : super(key: key);

  @override
  _CommoditieScreenTabState createState() => _CommoditieScreenTabState();
}

class _CommoditieScreenTabState extends State<CommoditieScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CommoditiesScreen();
  }

  @override
  bool get wantKeepAlive => true;
}