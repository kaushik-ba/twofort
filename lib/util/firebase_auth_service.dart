import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService{
  final FirebaseAuth _auth= FirebaseAuth.instance;

  Future<User?> logIn(String email, String password) async {
  final UserCredential userCredential  =await _auth.signInWithEmailAndPassword(email: email, password: password);
  return userCredential.user;
  }

  Future<User?> signUp(String email, String password) async {
    final UserCredential userCredential  =await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }
}