import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding/onboarding_page_view.dart';
import '../welcom/welcom_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  Future<void> _checkAppState(BuildContext context) async {
    // Kiem tra kOnboardingCompleted
    final isCompleted = await _isOnboardingCompleted();
    if (isCompleted) {
      if (!context.mounted) {
        return;
      }
      // Di chuyen den man hinh WelCome
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WelcomePage(isFirstTimeInstallApp: false)));
    } else {
      if (!context.mounted) {
        return;
      }
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoardingPageView()));
    }
  }

  Future<bool> _isOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool('kOnboardingCompleted');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAppState(context);
    });
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: _buildBodyPage(),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconSplash(),
          _buildTextSplash(),
        ],
      ),
    );
  }

  Widget _buildIconSplash() {
    return Image.asset(
      'assets/images/splash_icon.png',
      width: 95,
      height: 80,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextSplash() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text(
        'UpTodo',
        style: TextStyle(
            fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
