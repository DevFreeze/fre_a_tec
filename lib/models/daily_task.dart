import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTaskModel {
  final String id;
  final String title;
  final String pictureURL;

  DailyTaskModel({
    this.id,
    this.title,
    this.pictureURL,
  });

  factory DailyTaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DailyTaskModel(
      id: snapshot.id,
      title: snapshot.data()['title'],
      pictureURL: snapshot.data()['pictureURL'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': this.title,
    'pictureURL': this.pictureURL,
  };
}
