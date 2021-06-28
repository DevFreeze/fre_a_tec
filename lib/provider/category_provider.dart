import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fre_a_tec/models/daily_task.dart';

import 'package:fre_a_tec/services/category_service.dart';
import 'package:fre_a_tec/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

import '../services.dart';

class CategoryProvider extends ChangeNotifier {

  CategoryService _categoryService = services<CategoryService>();
  StorageService _storageService = services<StorageService>();

  Stream<QuerySnapshot> categoryStream() {
    return _categoryService.categoryStream();
  }

  Stream<QuerySnapshot> dailyTaskStream() {
    return _categoryService.dailyTaskStream();
  }

  Future<void> addDailyTask(String title, PickedFile file) async {

    String downloadURL = await _storageService.uploadFile('dailyTasks', file);

    final dailyTask = DailyTaskModel(
      title: title,
      pictureURL: downloadURL,
    );

    _categoryService.addDailyTask(dailyTask.toJson());
  }

}