

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';

import '../services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  Future<void> _signOut(BuildContext context) async {
    // await Firebase.initializeApp();
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

   Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
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
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
