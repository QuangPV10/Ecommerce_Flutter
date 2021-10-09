import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/services/global_method.dart';

class WishlistFull extends StatefulWidget {
  final productId;

  const WishlistFull({Key key, this.productId}) : super(key: key);

  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final favsAttr = Provider.of<FavoriteModel>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favsAttr.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${favsAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId),
      ],
    );
  }

  Widget positionedRemove(String productId) {
    final favsProvider = Provider.of<FavoriteProvider>(context);
    GlobalMethods globalMethod = GlobalMethods();
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          color: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            globalMethod.customShowDialog(
                'Remove Wish',
                'This product will be remove from the wishlist',
                () => favsProvider.addAndRemoveFromFavs(
                    productId: widget.productId),
                context);
            ;
          },
        ),
      ),
    );
  }
}
