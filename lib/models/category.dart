import 'package:cloud_firestore/cloud_firestore.dart';

class Kategory {
  final String id;
  final String title;
  final String imageUrl;

  Kategory({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Kategory{id: $id, title: $title, imageUrl: $imageUrl}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  factory Kategory.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return Kategory(
      id: query.id,
      title: query['title'] as String,
      imageUrl: query['imageUrl'] as String,
    );
  }
}
