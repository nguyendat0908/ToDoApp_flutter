import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domains/authentication_repository.dart';
import 'package:todo_app/ui/login/bloc/login_cubit.dart';
import 'package:todo_app/ui/register/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          final authenticationRepository =
              context.read<AuthenticationRepository>();
          return LoginCubit(authenticationRepository: authenticationRepository);
        },
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var _autoVaildateMode = AutovalidateMode.disabled;
  final _emailTextController = TextEditingController();
  final _passwordController = TextEditingController();

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
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageTitle(),
              const SizedBox(
                height: 53,
              ),
              _buildFormLogin(),
              _buildOrSplitDivider(),
              _buildSocialLogin(),
              _buildHaveNotAccount(context),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildPageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
      child: Text(
        'Đăng nhập',
        style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontSize: 32,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormLogin() {
    return Form(
        key: _formKey,
        autovalidateMode: _autoVaildateMode,
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
              _buildLoginButton(),
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
                fillColor: Color(0xFF1D1D1D),
                filled: true),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Bắt buộc phải nhập Email!"; // Yêu cầu nhập email
              }
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
              // Khi email hợp lệ
              if (emailValid) {
                return null;
              } else {
                return "Email không hợp lệ!";
              }
            },
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
                fillColor: Color(0xFF1D1D1D),
                filled: true),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Bắt buộc phải nhập mật khẩu";
              }
              if (value.length < 6) {
                return "Mật khẩu phải có 6 chữ số";
              }
              return null;
            },
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

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 70),
      child: ElevatedButton(
          onPressed: _onHandleLoginSubmit, // Muốn disabled thì để null
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              disabledBackgroundColor: Color(0xFF8687E7).withOpacity(0.5)),
          child: const Text(
            'Đăng nhập',
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
            'HOẶC',
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

  Widget _buildSocialLogin() {
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
                  'Đăng nhập với tài khoản Google',
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
                  'Đăng nhập với tài khoản Apple',
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

  Widget _buildHaveNotAccount(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
            text: 'Bạn chưa có tài khoản?',
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              color: Color(0xFF979797),
            ),
            children: [
              TextSpan(
                  text: ' Đăng ký',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Lato',
                    color: Colors.white.withOpacity(0.87),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _gotoRegisterPage(context);
                    })
            ]),
      ),
    );
  }

  void _gotoRegisterPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void _onHandleLoginSubmit() {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final email = _emailTextController.text;
    final password = _passwordController.text;
    loginCubit.login(email, password);

    if (_autoVaildateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoVaildateMode = AutovalidateMode.always;
      });
    }
    final isVaild = _formKey.currentState?.validate() ?? false;
    if (isVaild) {
      // Call firebase login
    } else {
      // Không làm gì cả
    }
  }
}
