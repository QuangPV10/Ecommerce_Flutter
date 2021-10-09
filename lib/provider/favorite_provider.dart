import 'package:flutter/material.dart';
import 'package:shop_app/models/favorite.dart';

class FavoriteProvider with ChangeNotifier {
  Map<String, FavoriteModel> _favsItems = {};

  Map<String, FavoriteModel> get getFavsItems {
    return {..._favsItems};
  }

  void addAndRemoveFromFavs(
      {String productId, double price, String title, String imageUrl}) {
    if (_favsItems.containsKey(productId)) {
      removeItem(productId: productId);
    } else {
      _favsItems.putIfAbsent(
          productId,
          () => FavoriteModel(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem({String productId}) {
    _favsItems.remove(productId);
    notifyListeners();
  }

  void clearFavs() {
    _favsItems.clear();
    notifyListeners();
  }
}
