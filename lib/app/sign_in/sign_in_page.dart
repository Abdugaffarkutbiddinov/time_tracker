import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/widgets/platform_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.bloc, required this.isLoading})
      : super(key: key);
  final SignInBloc bloc;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider(
          create: (_) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
              builder: (context, bloc, _) => SignInPage(
                    bloc: bloc,
                    isLoading: isLoading.value,
                  )),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: "Sign in failed",
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.signInWithFacebook();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50, child: _buildHeader()),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            color: Colors.white,
            onPressed: () => isLoading ? null : _signInWithGoogle(context),
            text: 'Sign in with Google',
            textColor: Colors.black87,
            assetName: 'images/google-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            color: const Color(0xFF334d92),
            onPressed: () => isLoading ? null : _signInWithFacebook(context),
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            assetName: 'images/facebook-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => isLoading ? null : _signInAnonymously(context),
            text: 'Go anonymous',
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
