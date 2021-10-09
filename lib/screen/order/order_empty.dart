import 'package:flutter/material.dart';
import 'package:shop_app/screen/feeds.dart';

class OrderEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://image.flaticon.com/icons/png/128/3759/3759041.png'))),
        ),
        Text(
          "Your Order Is Empty",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Look Like You didn't \n order anything yet",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).textSelectionColor,
            fontSize: 26,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Feeds.routeName);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.redAccent)),
            child: Text(
              "Shop now".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
