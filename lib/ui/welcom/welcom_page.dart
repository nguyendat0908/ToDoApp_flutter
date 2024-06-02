import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final isFirstTimeInstallApp;
  const WelcomePage({
    super.key,
    this.isFirstTimeInstallApp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: isFirstTimeInstallApp
            ? IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      body: Column(
        children: [
          _buildTitleAndDesc(),
          const Spacer(),
          _buildButtonLogin(),
          _buildButtonRegister(),
        ],
      ),
    );
  }

  Widget _buildTitleAndDesc() {
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 51,
          ),
          Text(
            'Welcome to UpTodo',
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
              'Please login to your account or create new account to continue',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.67),
                  fontFamily: 'Lato'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          onPressed: () {
            //
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: const Text(
            'LOGIN',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Colors.white),
          )),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: ElevatedButton(
          onPressed: () {
            //
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(
                width: 1,
                color: Color(0xFF8875FF),
              )),
          child: const Text(
            'CREATE ACCOUNT',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Colors.white),
          )),
    );
  }
}
