import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Stream<User?> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((firebaseUser) => firebaseUser);
  }

  // Giao tiep voi firebase
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    // Thuc hien logic dang nhap voi firebase
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
