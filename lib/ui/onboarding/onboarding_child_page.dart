// Dong vai tro la giao dien man hinh

import 'package:flutter/material.dart';

import '../../ultils/ultils.enums/onboarding_page_position.dart';

class OnBoardingChildPage extends StatelessWidget {
  final OnboardingPagePosition onboardingPagePosition;
  final VoidCallback nextOnPressed;
  final VoidCallback backOnPressed;
  final VoidCallback skipOnPresed;
  const OnBoardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.nextOnPressed,
      required this.backOnPressed,
      required this.skipOnPresed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildShipButton(),
              _buildOnBoardingImage(),
              _buildOnBoardingPageControl(),
              _buildOnBoardingTitleAndContent(),
              _buildOnBoardingNextAndPrevButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShipButton() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      alignment: AlignmentDirectional.centerStart,
      child: TextButton(
        onPressed: skipOnPresed,
        child: Text(
          'SKIP',
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.44)),
        ),
      ),
    );
  }

  Widget _buildOnBoardingImage() {
    return Image.asset(
      onboardingPagePosition.onboardingPageImage(),
      height: 296,
      width: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnBoardingPageControl() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Vi tri 1
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page1
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          // Vi tri 2
          Container(
            height: 4,
            width: 26,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page2
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          // Vi tri 3
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosition.page3
                  ? Colors.white
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOnBoardingTitleAndContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 51,
          ),
          Text(
            onboardingPagePosition.onboardingPageTitle(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 32,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 42,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onboardingPagePosition.onboardingPageContent(),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.87),
                  fontFamily: 'Lato'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnBoardingNextAndPrevButton() {
    return Container(
      margin: const EdgeInsets.only(top: 108, bottom: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                backOnPressed();
              },
              child: Text(
                'BACK',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
                onPressed: () {
                  nextOnPressed();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8875FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                child: Text(
                  onboardingPagePosition == OnboardingPagePosition.page3
                      ? 'GET STARTED'
                      : 'NEXT',
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
