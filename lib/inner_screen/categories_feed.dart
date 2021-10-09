import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/widget/feed_product.dart';

class CategoriesFeed extends StatelessWidget {
  static const routeName = '/CategoriesFeed';

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    print(categoryName);
    List<Product> products = productProvider.findByCategory(categoryName);
    return Scaffold(
        body: products.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.confirmation_num_rounded,
                      size: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No product related to this categories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.red),
                    ),
                  ],
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 240 / 420,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(products.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: products[index], child: FeedProducts());
                }),
              ));
  }
}
