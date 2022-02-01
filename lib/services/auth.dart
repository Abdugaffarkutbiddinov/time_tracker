import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  UserAuth({required this.uid});
  final String uid;
}
abstract class AuthBase {
  Future<UserAuth?> currentUser();
  Future<UserAuth?> signInAnonymously();
  Future<void> signOut();
}

class Auth  implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;
  UserAuth? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserAuth(uid: user.uid);
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
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}