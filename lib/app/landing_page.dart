import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;
  void _updateUser(User? user) {
    setState(() {
      _user = user;

    });

  }

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }
  Future<void> _checkCurrentUser() async{
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    _updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null) {
      print('$_user USERRR' );
      return SignInPage(onSignIn: _updateUser,);
    }
    return HomePage(onSignOut: () => _updateUser(null));
  }
}
