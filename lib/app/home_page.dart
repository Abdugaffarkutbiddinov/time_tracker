import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';

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

   Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut();
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
