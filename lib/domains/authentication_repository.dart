import 'package:todo_app/domains/data_sources/firebase_auth_service.dart';

abstract class AuthenticationRepository {
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  AuthenticationRepositoryImpl({required this.firebaseAuthService});

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuthService.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
}
