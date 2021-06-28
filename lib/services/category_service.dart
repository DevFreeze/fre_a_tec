import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {

  CollectionReference _categoryCollectionReference = FirebaseFirestore.instance.collection('categories');
  CollectionReference _dailyTaskCollectionReference = FirebaseFirestore.instance.collection('dailyTasks');

  Stream<QuerySnapshot> categoryStream() {
    return _categoryCollectionReference.snapshots();
  }

  Stream<QuerySnapshot> dailyTaskStream() {
    return _dailyTaskCollectionReference.snapshots();
  }

  Future<void> addDailyTask(Map json) {
    return _dailyTaskCollectionReference.doc().set(json);
  }

}