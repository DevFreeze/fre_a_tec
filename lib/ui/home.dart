import 'package:flutter/material.dart';
import 'package:fre_a_tec/ui/screens/admin/admin.dart';

import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/user_provider.dart';
import 'screens/profile/profile.dart';
import 'screens/categories/categories.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool withAdminTab = false;

  @override
  void initState() {
    super.initState();
    withAdminTab = Provider.of<UserProvider>(context, listen: false).currentUser.isAdmin;
    _tabController = TabController(vsync: this, length: withAdminTab ? 3 : 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, userProvider, __) {
        return Scaffold(
          body: _body(),
          bottomNavigationBar: _bottomAppBar(),
          //floatingActionButton: userProvider.currentUser.isAdmin ? _floatingActionButton() : null,
        );
      }
    );
  }

  TabBarView _body() {
    return TabBarView(
      children: <Widget>[
        Categories(),
        Profile(),
        if(withAdminTab) Admin()
      ],
      controller: _tabController,
    );
  }

  BottomAppBar _bottomAppBar() {
    return BottomAppBar(
      child: TabBar(
        controller: _tabController,
        tabs: [
          _tab(Icons.category, "Kategorien"),
          _tab(Icons.person, "Profil"),
          if(withAdminTab) _tab(Icons.admin_panel_settings, "Admin"),
        ],
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black12,
        indicator: BoxDecoration(),
      ),
    );
  }

  Tab _tab(IconData iconData, String text) {
    return Tab(
      icon: Icon(
        iconData,
        size: 24.0,
      ),
      text: text,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {

      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
