import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/login/login_page.dart';
import 'package:todo_app/ui/register/bloc/register_cubit.dart';

import '../../domains/authentication_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
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
          )),
      body: BlocProvider(
          create: (BuildContext context) {
            final authenticationRepository =
                context.read<AuthenticationRepository>();
            return RegisterCubit(
                authenticationRepository: authenticationRepository);
          },
          child: const RegisterView()),
      resizeToAvoidBottomInset: false,
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailTextController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageTitle(),
            const SizedBox(
              height: 53,
            ),
            _buildFormRegister(),
            _buildOrSplitDivider(),
            _buildSocialRegister(),
            _buildHaveAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
      child: Text(
        'Đăng ký',
        style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontSize: 32,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormRegister() {
    return Form(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserNameField(),
          const SizedBox(
            height: 25,
          ),
          _buildPasswordField(),
          const SizedBox(
            height: 25,
          ),
          _buildConFirmPasswordField(),
          _buildRegisterButton(),
        ],
      ),
    ));
  }

  Widget _buildUserNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tên người dùng',
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
                hintText: "Nhập tên người dùng của bạn",
                hintStyle: const TextStyle(
                    color: Color(0xFF535353), fontSize: 16, fontFamily: 'Lato'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: const Color(0xFF1D1D1D),
                filled: true),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
                fontFamily: 'Lato'),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mật khẩu',
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: "* * * * * * * * * * * *",
                hintStyle: const TextStyle(
                    color: Color(0xFF535353), fontSize: 16, fontFamily: 'Lato'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: const Color(0xFF1D1D1D),
                filled: true),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
                fontFamily: 'Lato'),
            obscureText: true,
          ),
        )
      ],
    );
  }

  Widget _buildConFirmPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xác nhận mật khẩu',
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 16,
              fontFamily: 'Lato'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: "* * * * * * * * * * * *",
                hintStyle: const TextStyle(
                    color: Color(0xFF535353), fontSize: 16, fontFamily: 'Lato'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: const Color(0xFF1D1D1D),
                filled: true),
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
                fontFamily: 'Lato'),
            obscureText: true,
          ),
        )
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 70),
      child: ElevatedButton(
          onPressed: _onTapRegister, // Muốn disabled thì để null
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              disabledBackgroundColor: Color(0xFF8687E7).withOpacity(0.5)),
          child: const Text(
            'Đăng ký',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Colors.white),
          )),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 45, bottom: 40),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
          const Text(
            'OR',
            style: TextStyle(
                fontSize: 16, fontFamily: 'Lato', color: Color(0xFF979797)),
          ),
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialRegister() {
    return Column(
      children: [_buildSocialGoogleLogin(), _buildSocialAppleLogin()],
    );
  }

  Widget _buildSocialGoogleLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/social_google_logo.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  'Đăng ký với Google',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Colors.white.withOpacity(0.87)),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildSocialAppleLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 24),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/social_apple_logo.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  'Đăng ký với Apple',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Colors.white.withOpacity(0.87)),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildHaveAccount(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
            text: 'Bạn có sẵn sàng để tạo một tài khoản?',
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              color: Color(0xFF979797),
            ),
            children: [
              TextSpan(
                  text: 'Đăng nhập',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Lato',
                    color: Colors.white.withOpacity(0.87),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _gotoLoginPage(context);
                    })
            ]),
      ),
    );
  }

  void _gotoLoginPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  void _onTapRegister() {
    final registerCubit = context.read<RegisterCubit>();
    final email = _emailTextController.text;
    final password = _passwordController.text;
    registerCubit.register(email, password);
  }
}
