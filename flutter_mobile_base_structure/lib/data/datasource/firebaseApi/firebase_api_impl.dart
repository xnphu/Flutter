import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_api.dart';

class FirebaseApiImpl implements FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
//      User user = userCredential.user;
      return result.user.uid;
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
