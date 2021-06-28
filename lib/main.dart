import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'provider/auth_provider.dart';
import 'provider/category_provider.dart';
import 'provider/user_provider.dart';
import 'routes.dart';
import 'services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setupServices();

  await services.allReady();

  runZoned(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => services<AuthProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => services<CategoryProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => services<UserProvider>(),
          ),
        ],
        child: FreATecApp(),
      ),
    );
  });
}

class FreATecApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, authProvider, __) {
      return MaterialApp(
        title: 'Fre-A-Tec',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Routes.routes,
        home: Auth(),
      );
    });
  }
}
