import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screen/landing_page.dart';
import 'package:shop_app/screen/main_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          // ignore : missing_return
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              return MainScreens();
            } else {
              return LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text("Error occured"),
            );
          }
        }
        );
  }
}
