import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screen/brands_navigation_rail.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/widget/backlayer.dart';
import 'package:shop_app/widget/category.dart';
import 'package:shop_app/widget/popular_product.dart';

import 'feeds.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _carouselImages = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.png'
  ];

  List _brandImages = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/Dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
    'assets/images/Huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    productData.fetchProduct();
    final popularItems = productData.getPopularProduct();
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            title: Text("Home"),
            leading: BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.purpleAccent])),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                iconSize: 15,
                icon: (CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                        'https://i.ytimg.com/vi/ETsekJKsr3M/maxresdefault.jpg'),
                  ),
                )),
                padding: EdgeInsets.all(10),
              )
            ],
          ),
          backLayer: BackLayerMenu(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  child: Carousel(
                    boxFit: BoxFit.fill,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 5,
                    dotIncreasedColor: Colors.black.withOpacity(0.2),
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    showIndicator: true,
                    indicatorBgPadding: 5.0,
                    images: [
                      ExactAssetImage(_carouselImages[1]),
                      ExactAssetImage(_carouselImages[2]),
                      ExactAssetImage(_carouselImages[3]),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Category(
                          index: index,
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        'Popular Brands',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            BrandNavigationRailScreen.routeName,
                            arguments: {
                              7,
                            },
                          );
                        },
                        child: Text(
                          'View all...',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Swiper(
                    itemCount: _brandImages.length,
                    autoplay: true,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    onTap: (index) {
                      Navigator.of(context).pushNamed(
                        BrandNavigationRailScreen.routeName,
                        arguments: {
                          index,
                        },
                      );
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.blueGrey,
                            child: Image.asset(
                              _brandImages[index],
                              fit: BoxFit.fill,
                            )),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        'Popular Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Feeds.routeName,arguments: 'popular');
                        },
                        child: Text(
                          'View all...',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 285,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: popularItems[index],
                            child: PopularProdcut());
                      }
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
