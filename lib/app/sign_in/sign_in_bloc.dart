import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc {
  SignInBloc({required this.auth, required this.isLoading});
  final ValueNotifier<bool> isLoading;
  final AuthBase auth;

  Future<UserAuth?> _signIn(Future<UserAuth?> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<UserAuth?> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<UserAuth?> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);

  Future<UserAuth?> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}
