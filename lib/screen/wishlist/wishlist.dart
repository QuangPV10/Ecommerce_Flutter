import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/screen/wishlist/wishlist_empty.dart';
import 'package:shop_app/services/global_method.dart';
import 'package:shop_app/screen/wishlist/wishlist_full.dart';

class Wishlist extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavoriteProvider>(context);
    GlobalMethods globalMethod = GlobalMethods();
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist (${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                      globalMethod.customShowDialog(
                          'Clear WishList',
                          'Your WishList will be cleared ',
                          () => favsProvider.clearFavs(),
                          context);
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: favsProvider.getFavsItems.values.toList()[index],
                    child: WishlistFull(
                      productId: favsProvider.getFavsItems.keys.toList()[index],
                    ));
              },
            ),
          );
  }
}
