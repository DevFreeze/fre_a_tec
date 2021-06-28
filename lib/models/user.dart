import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:fre_a_tec/utils/enums/role.dart';

class UserModel {
  final String id;
  final DocumentReference reference;
  final bool hasNewPassword;
  final String firstName;
  final String lastName;
  final Role role;

  UserModel({
    this.id,
    this.reference,
    this.hasNewPassword,
    this.firstName,
    this.lastName,
    this.role,
  });

  bool get isAdmin => this.role == Role.admin;

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.id,
      reference: snapshot.reference,
      hasNewPassword: snapshot.data()['hasNewPassword'],
      role: snapshot.data()['role'] != null
          ? EnumToString.fromString(Role.values, snapshot.data()['role'])
          : null,
      firstName: snapshot.data()['firstName'],
      lastName: snapshot.data()['lastName'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hasNewPassword': this.hasNewPassword,
        'firstName': this.firstName,
        'lastName': this.lastName,
        'role': EnumToString.convertToString(this.role),
      };
}
