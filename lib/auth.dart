import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';
import 'provider/user_provider.dart';
import 'ui/home.dart';
import 'ui/screens/common/loading.dart';
import 'ui/screens/login/login.dart';
import 'ui/screens/setup/set_password.dart';
import 'ui/screens/setup/set_user_data.dart';
import 'utils/enums/auth_status.dart';
import 'utils/enums/user_status.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProvider>(
        builder: (_, authProvider, userProvider, __) {
      switch (authProvider.status) {
        case AuthStatus.unauthenticated:
          return Login();
          break;
        case AuthStatus.authenticating:
          return LoadingScreen();
          break;
        case AuthStatus.authenticated:
          switch (userProvider.status) {
            case UserStatus.unknown:
              return Login();
              break;
            case UserStatus.notInDB:
              return SetUserData();
              break;
            case UserStatus.inDBWithoutPassword:
              return SetPassword();
              break;
            case UserStatus.inDatabase:
              return Home();
              break;
            default:
              return Login();
              break;
          }
          break;
        case AuthStatus.unknown:
          return LoadingScreen();
          break;
        default:
          return Login();
          break;
      }
    });
  }
}
