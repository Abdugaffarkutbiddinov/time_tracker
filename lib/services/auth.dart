import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  UserAuth({required this.uid});

  final String uid;
}

abstract class AuthBase {
  Future<UserAuth?> currentUser();

  Future<UserAuth?> signInAnonymously();

  Future<UserAuth?> signInWithGoogle();

  Future<UserAuth?> signInWithFacebook();

  Future<void> signOut();

  Stream<UserAuth?> get onAuthStateChanged;
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserAuth? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserAuth(uid: user.uid);
  }

  @override
  Stream<UserAuth?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserAuth?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<UserAuth?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<UserAuth?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<UserAuth?> signInWithFacebook() async {
    final result = await FacebookAuth.i.login(permissions: ["public_profile"]);
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(result.accessToken!.token));
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    await _firebaseAuth.signOut();
  }
}
