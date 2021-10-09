import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItem {
    return {..._cartItems};
  }

  double get totalAmount {
    double total = 0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
      {String productId, double price, String title, String imageUrl}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartModel(
              id: existingCartItem.id,
              productId: existingCartItem.productId,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              imageUrl: existingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartModel(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void reduceItemByOne({String productId}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartModel(
              id: existingCartItem.id,
              productId: existingCartItem.productId,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              imageUrl: existingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem({String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
