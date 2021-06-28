import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {

  final _firebaseStorage = FirebaseStorage.instance;

  /// The user selects a file, and the task is added to the list.
  Future<String> uploadFile(String folder, PickedFile file) async {

    final uuid = Uuid().v1();

    // Create a Reference to the file
    Reference ref = _firebaseStorage
        .ref()
        .child(folder)
        .child('/$uuid.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    await ref.putFile(File(file.path), metadata);

    String url = await ref.getDownloadURL();
    return url;
  }
}