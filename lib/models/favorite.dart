import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavoriteModel({
    this.id,
    this.title,
    this.price,
    this.imageUrl,
  });
}
