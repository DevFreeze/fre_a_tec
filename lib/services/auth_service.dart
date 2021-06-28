import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> authStatusStream = _auth.authStateChanges();

  Future<User> registerWithMail(String email, String password) async {
    return (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
  }

  Future<void> signInWithMail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
