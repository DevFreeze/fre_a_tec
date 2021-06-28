import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fre_a_tec/models/user.dart';
import 'package:fre_a_tec/services/user_service.dart';
import 'package:fre_a_tec/utils/enums/role.dart';
import 'package:fre_a_tec/utils/enums/user_status.dart';

import '../services.dart';

class UserProvider extends ChangeNotifier {

  UserService _userService = services<UserService>();

  UserModel currentUser;
  UserStatus status = UserStatus.unknown;

  StreamController<UserStatus> userStatusStreamController = StreamController<UserStatus>();

  UserProvider() {
    userStatusStreamController.stream.listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  Future<void> setUserById(String uid) async {
    DocumentSnapshot snapshot = await _userService.getUserSnapshotById(uid);

    if (snapshot != null) {
      currentUser = UserModel.fromSnapshot(snapshot);
      if(currentUser.hasNewPassword) {
        status = UserStatus.inDatabase;
      } else {
        status = UserStatus.inDBWithoutPassword;
      }
    } else {
      print("NO");
      currentUser = UserModel(
        id: uid,
      );
      status = UserStatus.notInDB;
    }
    notifyListeners();
  }

  Future<void> writeUserInDB(String firstName, String lastName) async {
    final user = UserModel(
      role: Role.azubi,
      firstName: firstName,
      lastName: lastName,
      hasNewPassword: false,
    );

    await _userService.writeUserInDB(currentUser.id, user.toJson());
    setUserById(currentUser.id);
  }

  @override
  void dispose() {
    userStatusStreamController.close();
    super.dispose();
  }



}