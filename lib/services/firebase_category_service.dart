import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseCategoryService {
  final _categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  final _categoriesImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getCategories() async* {
    yield* _categoriesCollection.snapshots();
  }

  Future<void> addCategory({
    required String imageId,
    required File imageFile,
    required String title,
  }) async {
    final imageReference = _categoriesImageStorage
        .ref()
        .child('categoryImages')
        .child("$imageId.jpg");
    final uploadTask = imageReference.putFile(imageFile);

    /// Listening to Uploading progress
    uploadTask.snapshotEvents.listen((status) {
      debugPrint("Uploading status: ${status.state}");
      double percentage =
          (status.bytesTransferred / imageFile.lengthSync()) * 100;
      debugPrint("Uploading percentage: $percentage");
    });

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _categoriesCollection.add({
        "imageUrl": imageUrl,
        "title": title,
      });
    });
  }
}
