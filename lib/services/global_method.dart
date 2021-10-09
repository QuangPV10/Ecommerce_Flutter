import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> customShowDialog(
      String title, String subTitle, Function fct, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/OOjs_UI_icon_alert-destructive.svg/1200px-OOjs_UI_icon_alert-destructive.svg.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Text(title)
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  Future<void> authErrorHandle(String subTitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/OOjs_UI_icon_alert-destructive.svg/1200px-OOjs_UI_icon_alert-destructive.svg.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Text('Error occured')
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
