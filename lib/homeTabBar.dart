import 'package:flutter/material.dart';
import 'tabBarController.dart';
import 'pages/site/SiteScreen.dart';
import 'pages/strategy/strategyScreen.dart';
import 'pages/groups/groupsScreen.dart';
import 'pages/settings/settings.dart';
import 'pages/commoditie/commoditieScreen.dart';
import 'pages/dashboard/dashboard.dart';
import 'pages/TokenScreen/TokenScreen.dart';

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
          title: 'Estratégias',
          tab: const StrategyScreenTab(),
          icon: Icons.show_chart,
        ),
        PersistentTabItem(
          title: 'Commodities',
          tab: const CommoditieScreenTab(),
          icon: Icons.wallet,
        ),
        PersistentTabItem(
          title: 'Sites',
          tab: const SiteScreenTab(),
          icon: Icons.link,
        ),
        PersistentTabItem(
          title: 'Tokens',
          tab: const TokenScreenTab(),
          icon: Icons.label_important,
        ),
        PersistentTabItem(
          title: 'Grupos',
          tab: const GroupsScreenTab(),
          icon: Icons.chat,
        ),
        PersistentTabItem(
          title: 'Configurações',
          tab: const SettingsScreenTab(),
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

class SettingsScreenTab extends StatefulWidget {
  const SettingsScreenTab({Key? key}) : super(key: key);

  @override
  _SettingsScreenTabState createState() => _SettingsScreenTabState();
}

class _SettingsScreenTabState extends State<SettingsScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Settings();
  }

  @override
  bool get wantKeepAlive => true;
}

class GroupsScreenTab extends StatefulWidget {
  const GroupsScreenTab({Key? key}) : super(key: key);

  @override
  _GroupsScreenTabState createState() => _GroupsScreenTabState();
}

class _GroupsScreenTabState extends State<GroupsScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GroupsScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class StrategyScreenTab extends StatefulWidget {
  const StrategyScreenTab({Key? key}) : super(key: key);

  @override
  _StrategyScreenTabState createState() => _StrategyScreenTabState();
}

class _StrategyScreenTabState extends State<StrategyScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StrategyScreen();
  }

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
    return CommoditieScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class SiteScreenTab extends StatefulWidget {
  const SiteScreenTab({Key? key}) : super(key: key);

  @override
  _SiteScreenTabState createState() => _SiteScreenTabState();
}

class _SiteScreenTabState extends State<SiteScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SiteScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class TokenScreenTab extends StatefulWidget {
  const TokenScreenTab({Key? key}) : super(key: key);

  @override
  _TokenScreenTabState createState() => _TokenScreenTabState();
}

class _TokenScreenTabState extends State<TokenScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TokenScreen();
  }

  @override
  bool get wantKeepAlive => true;
}
