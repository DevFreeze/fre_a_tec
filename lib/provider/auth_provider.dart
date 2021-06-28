import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fre_a_tec/services/auth_service.dart';
import 'package:fre_a_tec/utils/enums/auth_status.dart';
import 'package:fre_a_tec/utils/enums/user_status.dart';

import '../services.dart';
import 'user_provider.dart';

class AuthProvider extends ChangeNotifier {
  AuthService _authService = services<AuthService>();
  UserProvider _userProvider = services.get<UserProvider>();

  User user;
  AuthStatus status = AuthStatus.unknown;
  StreamSubscription userAuthStatusSub;

  AuthProvider() {
    userAuthStatusSub = _authService.authStatusStream.listen((newUser) async {
      print('AuthProvider: $newUser');

      user = newUser;
      if (user == null) {
        status = AuthStatus.unauthenticated;
      } else {
        await _userProvider.setUserById(user.uid);
        status = AuthStatus.authenticated;
      }
      notifyListeners();
    });
  }

  Future<void> signInWithMail(String email, String password) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    await _authService.signInWithMail(email, password);
  }

  Future<String> updatePassword(String newPassword) async {
    try {
      await user.updatePassword(newPassword);
      _userProvider.currentUser.reference.update({
        'hasNewPassword': true,
      });
      _userProvider.userStatusStreamController.add(UserStatus.inDatabase);
      return "success"; // Not really necessary
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> signOut() async {
    _authService.signOut();
  }

  @override
  void dispose() {
    userAuthStatusSub.cancel();
    super.dispose();
  }
}
