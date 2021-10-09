import 'package:flutter/material.dart';
import 'package:shop_app/inner_screen/categories_feed.dart';

class Category extends StatefulWidget {
  final int index;

  Category({Key key, this.index}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImagesPath': 'assets/images/CatPhones.png',
    },
    {
      'categoryName': 'Clothes',
      'categoryImagesPath': 'assets/images/CatClothes.jpg',
    },
    {
      'categoryName': 'Shoes',
      'categoryImagesPath': 'assets/images/CatShoes.jpg',
    },
    {
      'categoryName': 'Beauty&Health',
      'categoryImagesPath': 'assets/images/CatBeauty.jpg',
    },
    {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'assets/images/CatLaptops.png',
    },
    {
      'categoryName': 'Furniture',
      'categoryImagesPath': 'assets/images/CatFurniture.jpg',
    },
    {
      'categoryName': 'Watches',
      'categoryImagesPath': 'assets/images/CatWatches.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeed.routeName,
                arguments: "${categories[widget.index]['categoryName']}");
            print("${categories[widget.index]['categoryName']}");
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                        categories[widget.index]['categoryImagesPath']),
                    fit: BoxFit.cover)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 150,
            width: 150,
          ),
        ),
        Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).backgroundColor,
              child: Text(
                categories[widget.index]['categoryName'],
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Theme.of(context).textSelectionColor),
              ),
            ))
      ],
    );
  }
}
