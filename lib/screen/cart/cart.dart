import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/services/global_method.dart';
import 'package:shop_app/services/payment.dart';
import 'package:shop_app/screen/cart/cart_full.dart';
import 'package:uuid/uuid.dart';

import 'cart_empty.dart';

class Cart extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  var response;
  GlobalMethods globalMethod = GlobalMethods();

  Future<void> payWithCard({int amount}) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();
    print('response : ${response.success}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItem.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItem.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                      globalMethod.customShowDialog(
                          'Clear Cart',
                          'Your cart will be cleared ',
                          () => cartProvider.clearCart(),
                          context);
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItem.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItem.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItem.keys.toList()[index],
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext context, double subTotal) {
    final cartProvider = Provider.of<CartProvider>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var uuid = Uuid();
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
                child: InkWell(
                  onTap: () async {
                    double amountInCents = subTotal * 1000;
                    int intengerAmount = (amountInCents / 10).ceil();
                    await payWithCard(amount: intengerAmount);
                    if (response.success) {
                      User user = _auth.currentUser;
                      final _uid = user.uid;
                      cartProvider.getCartItem.forEach((key, orderValue) async {
                        final orderId = uuid.v4();
                        try {
                          await FirebaseFirestore.instance
                              .collection('order')
                              .doc(orderId)
                              .set({
                            'orderId': orderId,
                            'userId': _uid,
                            'productId': orderValue.productId,
                            'title': orderValue.title,
                            'price': orderValue.price * orderValue.quantity,
                            'imageUrl': orderValue.imageUrl,
                            'quantity': orderValue.quantity,
                            'orderDate': Timestamp.now(),
                          });
                        } catch (err) {
                          print('error occured $err');
                        }
                      });
                    } else {
                      globalMethod.authErrorHandle(
                          'Please enter your true information', context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total: ',
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            FittedBox(
              child: Text(
                "US ${subTotal.toStringAsFixed(3)}",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
