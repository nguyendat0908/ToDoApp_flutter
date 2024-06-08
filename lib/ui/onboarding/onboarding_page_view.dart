// Dong vai tro quan ly cac page con. Di chuyen qua lai cac page con

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ultils/ultils.enums/onboarding_page_position.dart';

import '../splash/splash.dart';
import '../welcom/welcom_page.dart';
import 'onboarding_child_page.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key});

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // Khong muon User vuot ngang
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Truyen vao cac widget con ma muon pageview hien thi
          OnBoardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page1,
            nextOnPressed: () {
              _pageController.jumpToPage(1);
            },
            backOnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
            skipOnPresed: () {
              _markOnboardingCompleted();
              _gotoWelcomePage();
            },
          ),
          OnBoardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page2,
            nextOnPressed: () {
              _pageController.jumpToPage(2);
            },
            backOnPressed: () {
              _pageController.jumpToPage(0);
            },
            skipOnPresed: () {
              _markOnboardingCompleted();
              _gotoWelcomePage();
            },
          ),
          OnBoardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page3,
            nextOnPressed: () {
              _markOnboardingCompleted();
              _gotoWelcomePage();
            },
            backOnPressed: () {
              _pageController.jumpToPage(1);
            },
            skipOnPresed: () {
              _markOnboardingCompleted();
              _gotoWelcomePage();
            },
          ),
        ],
      ),
    );
  }

  void _gotoWelcomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const WelcomePage(isFirstTimeInstallApp: true)));
  }

  Future<void> _markOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('kOnboardingCompleted', true);
    } catch (e) {
      print(e);
      return;
    }
  }
}
