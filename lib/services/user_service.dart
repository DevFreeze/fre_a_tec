import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getUserSnapshotById(String uid) async {
    DocumentSnapshot snapshot = await _usersCollectionReference.doc(uid).get();
    if (snapshot.exists) {
      return snapshot;
    }
    return null;
  }

  Future<void> writeUserInDB(String uid, Map userData) async {
    _usersCollectionReference.doc(uid).set(userData);
  }


}