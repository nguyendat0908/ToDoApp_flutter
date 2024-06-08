import 'package:flutter/material.dart';
import 'package:todo_app/ui/register/register_page.dart';

import '../login/login_page.dart';

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
          _buildButtonLogin(context),
          _buildButtonRegister(context),
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
            'Chào mừng đến với App',
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 28,
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
              'Vui lòng đăng nhập vào tài khoản của bạn hoặc tạo tài khoản mới để tiếp tục',
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

  Widget _buildButtonLogin(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: const Text(
            'Đăng nhập',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Colors.white),
          )),
    );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
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
            'Tạo mới tài khoản',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Colors.white),
          )),
    );
  }
}
