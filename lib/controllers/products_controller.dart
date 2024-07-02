import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_shop/services/firebase_product_service.dart';

class ProductsController extends ChangeNotifier {
  final _productsService = FirebaseProductService();

  Stream<QuerySnapshot> get products async* {
    yield* _productsService.getProducts();
  }
}
