import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/app_cubit.dart';
import 'package:todo_app/domains/authentication_repository.dart';
import 'package:todo_app/domains/data_sources/firebase_auth_service.dart';
import 'package:todo_app/ui/login/login_page.dart';
import 'package:todo_app/ui/main/main_page.dart';
import 'package:todo_app/ui/splash/splash.dart';
import 'package:todo_app/ultils/ultils.enums/authentication_status.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(const App());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuthService = FirebaseAuthService();
    _authenticationRepository =
        AuthenticationRepositoryImpl(firebaseAuthService: _firebaseAuthService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authenticationRepository),
      ],
      child: BlocProvider(
        create: (BuildContext context) {
          return AppCubit(authenticationRepository: _authenticationRepository);
        },
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                // Di den man home
                _navigatorKey.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                // Di den man login
                _navigatorKey.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                // Khong lam gi ca
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
