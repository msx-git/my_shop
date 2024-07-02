import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseProductService {
  final _productsCollection = FirebaseFirestore.instance.collection("products");
  final _productsImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  Future<void> addProduct({
    required String imageId,
    required File imageFile,
    required String categoryId,
    required int color,
    required String descriptionTitle,
    required String descriptionContent,
    required bool isFavorite,
    required double price,
    required List<Map<String, dynamic>> reviews,
    required String title,
    required String type,
  }) async {
    final imageReference = _productsImageStorage
        .ref()
        .child('productImages')
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
      await _productsCollection.add({
        "categoryId": categoryId,
        "color": color,
        "descriptionContent": descriptionContent,
        "descriptionTitle": descriptionTitle,
        "imageUrl": imageUrl,
        "isFavorite": isFavorite,
        "price": price,
        "reviews": reviews,
        "title": title,
        "type": type,
      });
    });
  }
}
