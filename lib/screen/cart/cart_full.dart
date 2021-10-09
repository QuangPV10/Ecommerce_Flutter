import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screen/product_details.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/services/global_method.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({Key key, this.productId});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethod = GlobalMethods();
    final cartAttr = Provider.of<CartModel>(context);
    final subTotal = cartAttr.quantity * cartAttr.price;
    final cartProvider = Provider.of<CartProvider>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: widget.productId);
      },
      child: SizedBox(
        child: Card(
          child: Container(
            height: 135,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Row(
              children: [
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage("${cartAttr.imageUrl}"),
                    // fit: BoxFit.fill
                  )),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "${cartAttr.title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(32),
                                onTap: () {
                                  globalMethod.customShowDialog(
                                      'Remove Item',
                                      'Product will be remove from the cart',
                                      () => cartProvider.removeItem(
                                          productId: widget.productId),
                                      context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Price: "),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${cartAttr.price} \$",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Sub Total: "),
                            SizedBox(
                              width: 5,
                            ),
                            FittedBox(
                              child: Text(
                                "${subTotal.toStringAsFixed(2)} \$",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: themeChange.darkTheme
                                        ? Colors.brown.shade900
                                        : Theme.of(context).accentColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Ship Free",
                              style: TextStyle(
                                  color: themeChange.darkTheme
                                      ? Colors.brown.shade900
                                      : Theme.of(context).accentColor),
                            ),
                            Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: cartAttr.quantity < 2
                                    ? null
                                    : () {
                                        cartProvider.reduceItemByOne(
                                          productId: widget.productId,
                                        );
                                      },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.remove,
                                    color: cartAttr.quantity < 2
                                        ? Colors.grey
                                        : Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 12,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.grey),
                                child: Text(
                                  "${cartAttr.quantity}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () {
                                  cartProvider.addProductToCart(
                                      productId: widget.productId,
                                      title: cartAttr.title,
                                      imageUrl: cartAttr.imageUrl,
                                      price: cartAttr.price);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
