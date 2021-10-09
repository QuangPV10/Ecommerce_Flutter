import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp oderDate;

  OrderModel({this.productId, this.price, this.title, this.imageUrl,
      this.quantity, this.oderDate, this.orderId, this.userId});
}
