import 'package:flutter/material.dart';
import 'package:fre_a_tec/ui/widgets/common/common_list_tile.dart';

import '../../../routes.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView(
        children: [
          CommonListTile(
            title: "Tagesaufgabe hinzufügen",
            onClick: () {
              Navigator.of(context).pushNamed(Routes.addDailyTask);
            },
          ),
          CommonListTile(title: "Kategorie hinzufügen"),
          CommonListTile(title: "Nutzer hinzufügen"),
          CommonListTile(title: "Dokument hinzufügen"),
        ],
      ),
    );
  }
}
