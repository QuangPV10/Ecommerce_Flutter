import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screen/brands_navigation_rail.dart';
import 'package:shop_app/inner_screen/categories_feed.dart';
import 'package:shop_app/inner_screen/product_details.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screen/auth/forget_password.dart';
import 'package:shop_app/screen/auth/login.dart';
import 'package:shop_app/screen/auth/sign_up.dart';
import 'package:shop_app/screen/bottom_bar.dart';
import 'package:shop_app/screen/cart/cart.dart';
import 'package:shop_app/screen/feeds.dart';
import 'package:shop_app/screen/order/order.dart';
import 'package:shop_app/screen/upload_product_form.dart';
import 'package:shop_app/screen/user_state.dart';
import 'package:shop_app/screen/wishlist/wishlist.dart';
import 'consts/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Text("Error occured"),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => themeChangeProvider),
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => FavoriteProvider()),
              ChangeNotifierProvider(create: (_) => OrderProvider()),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeData, child) {
              return MaterialApp(
                title: "APP SHOP",
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: UserState(),
                routes: {
                  // '/' : (context) => LandingPage();
                  BrandNavigationRailScreen.routeName: (context) =>
                      BrandNavigationRailScreen(),
                  Cart.routeName: (context) => Cart(),
                  Feeds.routeName: (context) => Feeds(),
                  Wishlist.routeName: (context) => Wishlist(),
                  ProductDetails.routeName: (context) => ProductDetails(),
                  CategoriesFeed.routeName: (context) => CategoriesFeed(),
                  BottomBarScreen.routeName: (context) => BottomBarScreen(),
                  LoginScreen.routeName: (context) => LoginScreen(),
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  UploadProductForm.routeName: (context) => UploadProductForm(),
                  ForgetPassword.routeName: (context) => ForgetPassword(),
                  Order.routeName: (context) => Order(),
                },
              );
            }),
          );
        });
  }
}
