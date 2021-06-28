import 'package:flutter/material.dart';
import 'package:fre_a_tec/models/daily_task.dart';

class DailyTaskScreen extends StatelessWidget {

  final DailyTaskModel dailyTaskModel;

  const DailyTaskScreen({Key key, this.dailyTaskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dailyTaskModel.title),
      ),
      body: Center(
        child: Image.network(dailyTaskModel.pictureURL),
      ),
    );
  }

}