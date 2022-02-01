import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({required this.onSignIn, required this.auth});
  final AuthBase auth;
  final Function(UserAuth) onSignIn;
  Future<void> _signInAnonymously() async {
    // await Firebase.initializeApp();
    try {
      UserAuth? user = await auth.signInAnonymously();
      onSignIn(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            color: Colors.white,
            onPressed: () {},
            text: 'Sign in with Google',
            textColor: Colors.black87,
            assetName: 'images/google-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            color: const Color(0xFF334d92),
            onPressed: () {},
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            assetName: 'images/facebook-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.teal[700],
            onPressed: () {},
            text: 'Sign in with Email',
            textColor: Colors.white,
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.blueGrey[300],
            onPressed: _signInAnonymously,
            text: 'Go anonymous',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
