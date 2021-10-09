import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/order.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get getOdersList => _orders;

  Future<void> fetchOrders() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var _uid = _auth.currentUser.uid;

    try {
      await FirebaseFirestore.instance
          .collection('order')
          .where('userId', isEqualTo: _uid)
          .get()
          .then((QuerySnapshot orderSnapshot) {
        _orders.clear();
        orderSnapshot.docs.forEach((element) {
          _orders.insert(
              0,
              OrderModel(
                productId: element.get('productId'),
                quantity: element.get('quantity').toString(),
                imageUrl: element.get('imageUrl'),
                price: element.get('price').toString(),
                title: element.get('title'),
                oderDate: element.get('orderDate'),
                orderId: element.get('orderId'),
                userId: element.get('userId'),
              ));
        });
      });
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }
}
