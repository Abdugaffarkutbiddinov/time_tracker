import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.auth});
  final AuthBase auth;
  Future<void> _signOut() async {
    // await Firebase.initializeApp();
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
