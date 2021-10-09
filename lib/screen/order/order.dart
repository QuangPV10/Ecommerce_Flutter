import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/screen/order/order_full.dart';
import 'package:shop_app/services/global_method.dart';
import 'package:shop_app/services/payment.dart';

import 'order_empty.dart';

class Order extends StatefulWidget {
  static const routeName = '/OrderScreen';

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  var response;

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
    // GlobalMethods globalMethod = GlobalMethods();
    final orderProvider = Provider.of<OrderProvider>(context);
    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.getOdersList.isEmpty
              ? Scaffold(
                  body: OrderEmpty(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title:
                        Text('Orders (${orderProvider.getOdersList.length})'),
                    actions: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        itemCount: orderProvider.getOdersList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: orderProvider.getOdersList[index],
                              child: OrderFull());
                        }),
                  ),
                );
        });
  }
}
