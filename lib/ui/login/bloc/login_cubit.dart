import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domains/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginCubit({required this.authenticationRepository})
      : super(const LoginState(""));

  Future<void> login(String email, String password) async {
    try {
      await authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {}
  }
}
