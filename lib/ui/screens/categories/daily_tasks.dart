import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fre_a_tec/models/daily_task.dart';
import 'package:fre_a_tec/provider/category_provider.dart';
import 'package:fre_a_tec/routes.dart';
import 'package:fre_a_tec/ui/widgets/common/common_list_tile.dart';
import 'package:provider/provider.dart';

class DailyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tagesaufgaben"),
      ),
      body: Consumer<CategoryProvider>(builder: (_, categoryProvider, __) {
        return StreamBuilder<QuerySnapshot>(
            stream: categoryProvider.dailyTaskStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    ...snapshot.data.docs.map((snap) {
                      final _dailyTask = DailyTaskModel.fromSnapshot(snap);
                      return CommonListTile(
                        title: _dailyTask.title,
                        onClick: () {
                        Navigator.of(context)
                            .pushNamed(Routes.dailyTask, arguments: _dailyTask);
                        },
                      );
                    }),
                  ],
                );
              }
              return Container();
            });
      }),
    );
  }
}
