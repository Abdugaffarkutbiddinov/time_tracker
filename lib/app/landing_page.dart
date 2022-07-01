import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<UserAuth?>(
      stream: auth.onAuthStateChanged,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserAuth? user = snapshot.data;
          if (user == null) {
            return SignInPage(
            );
          }
          return HomePage(
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
