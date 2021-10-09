import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screen/product_details.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';

class PopularProdcut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favsProvider = Provider.of<FavoriteProvider>(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetails.routeName,
                  arguments: productsAttributes.id);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(productsAttributes.imageUrl),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                      right: 12,
                      top: 8,
                      child: Icon(
                        favsProvider.getFavsItems
                                .containsKey(productsAttributes.id)
                            ? Icons.star
                            : Icons.star_border,
                        color: favsProvider.getFavsItems
                                .containsKey(productsAttributes.id)
                            ? Colors.redAccent
                            : Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 8,
                      child: Icon(
                        Icons.star_border,
                        color: Colors.black87,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${productsAttributes.price}',
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsAttributes.title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              productsAttributes.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800]),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: cartProvider.getCartItem
                                        .containsKey(productsAttributes.id)
                                    ? () {}
                                    : () {
                                        cartProvider.addProductToCart(
                                          productId: productsAttributes.id,
                                          price: productsAttributes.price,
                                          imageUrl: productsAttributes.imageUrl,
                                          title: productsAttributes.title,
                                        );
                                      },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      cartProvider.getCartItem.containsKey(
                                              productsAttributes.id)
                                          ? Icons.check
                                          : Icons.add_shopping_cart,
                                      size: 25,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
