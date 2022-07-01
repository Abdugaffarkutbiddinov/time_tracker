import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Sign In'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInForm(
          )),
        ),
      ),
    );
  }
}
