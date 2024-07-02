import 'package:flutter/material.dart';

class Product {
  final String id;
  final String categoryId;
  final int color;
  final String descriptionTitle;
  final String descriptionContent;
  final String imageUrl;
  bool isFavorite;
  final double price;
  final List<Map<String, dynamic>> reviews;
  final String title;
  final String type;

  Product({
    required this.id,
    required this.categoryId,
    required this.color,
    required this.descriptionTitle,
    required this.descriptionContent,
    required this.imageUrl,
    this.isFavorite = false,
    required this.price,
    required this.reviews,
    required this.title,
    required this.type,
  });
}
