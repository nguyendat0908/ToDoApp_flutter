import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domains/data_sources/firebase_auth_service.dart';
import 'package:todo_app/domains/user/user_entity.dart';
import 'package:todo_app/ultils/ultils.enums/authentication_status.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Stream<UserEntity> get user;

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  final _statusController = StreamController<AuthenticationStatus>();
  final _userController = StreamController<UserEntity>();
  AuthenticationRepositoryImpl({required this.firebaseAuthService}) {
    firebaseAuthService.user.listen((firebaseUser) {
      // Da login
      final isLoggedIn = firebaseUser != null;
      // Bien doi tu firebaseUser thanh UserEntity
      final user = isLoggedIn ? firebaseUser.toUserEntity : UserEntity.empty;
      _userController.sink.add(user);
      if (isLoggedIn) {
        _statusController.sink.add(AuthenticationStatus.authenticated);
      } else {
        _statusController.sink.add(AuthenticationStatus.unauthenticated);
      }
    });
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status async* {
    // Khong biet User đăng nhập hay chưa
    yield AuthenticationStatus.unauthenticated;
    yield* _statusController.stream;
  }

  @override
  // TODO: implement user
  Stream<UserEntity> get user async* {
    yield* _userController.stream;
  }

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

extension UserFirebaseAuthExtention on User {
  UserEntity get toUserEntity {
    return UserEntity(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}
