import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseApi {
  Future<String> signInWithEmailAndPassword({
    String email, String password});
  Future<void> logOut();
}
