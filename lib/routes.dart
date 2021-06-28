import 'package:flutter/material.dart';
import 'package:fre_a_tec/ui/screens/admin/add_daily_task.dart';
import 'package:fre_a_tec/ui/screens/categories/daily_task.dart';

import 'auth.dart';
import 'ui/home.dart';
import 'ui/screens/categories/daily_tasks.dart';
import 'ui/screens/common/loading.dart';
import 'ui/screens/login/login.dart';

class Routes {
  Routes._();

  static const String loading = "/loading";
  static const String home = '/home';
  static const String login = "/login";
  static const String dailyTasks = "/daily-tasks";
  static const String dailyTask = "/daily-task";
  static const String addDailyTask = "/add-daily-task";

  static final routes = <String, WidgetBuilder>{
    loading: (BuildContext context) => LoadingScreen(),
    home: (BuildContext context) => Home(),
    login: (BuildContext context) => Login(),
    dailyTasks: (BuildContext context) => DailyTasks(),
    dailyTask: (BuildContext context) => DailyTaskScreen(
      dailyTaskModel: ModalRoute.of(context).settings.arguments,
    ),
    addDailyTask: (BuildContext context) => AddDailyTask(),
  };

}