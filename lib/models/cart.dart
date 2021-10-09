import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartModel({
    this.id,
    this.productId,
    this.title,
    this.quantity,
    this.price,
    this.imageUrl,
  });
}
