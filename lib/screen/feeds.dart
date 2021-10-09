import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screen/wishlist/wishlist.dart';
import 'package:shop_app/widget/feed_product.dart';

import 'cart/cart.dart';

class Feeds extends StatefulWidget {
  static const routeName = '/Feeds';

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  Future<void> _getProductsFresh() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> products = productProvider.getListProduct;
    if (popular == 'popular') {
      products = ProductProvider().getPopularProduct();
      print(products.length);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Feeds'),
          actions: <Widget>[
            Consumer<FavoriteProvider>(
              builder: (_, favs, child) => Badge(
                badgeColor: Colors.purple,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  favs.getFavsItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Wishlist.routeName);
                  },
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (_, carts, child) => Badge(
                badgeColor: Colors.purple,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  carts.getCartItem.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Cart.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _getProductsFresh,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 420,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(products.length, (index) {
              return ChangeNotifierProvider.value(
                  value: products[index], child: FeedProducts());
            }),
          ),
        ));
  }
}
