import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_shop/services/firebase_category_service.dart';

class CategoriesController extends ChangeNotifier {
  final _categoryService = FirebaseCategoryService();

  Stream<QuerySnapshot> get categories async* {
    yield* _categoryService.getCategories();
  }

  Future<void> addCategory({
    required String imageId,
    required File imageFile,
    required String title,
  }) async {
    await _categoryService.addCategory(
        imageId: imageId, imageFile: imageFile, title: title);
  }
}
