import 'package:app/forms/password_information.dart';
import 'package:app/forms/user_information.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _login() async {
    final logInEmail = _emailController.text;
    final logInPassword = _passwordController.text;
    final List<dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>?;

    if (logInEmail.isNotEmpty && logInPassword.isNotEmpty) {
      if (arguments != null &&
          logInEmail == arguments[0] &&
          logInPassword == arguments[1]) {
        MyDialog.showAccountActivated(context);
      } else {
        MyDialog.showAccountNoActivated(context);
      }
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(250.0),
                      MyButton(title: "Log in", onPressed: _login),
                      const Gap(20.0),
                      _buildSocialLoginButtons(),
                      const Gap(20.0),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome Back",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Let's login to connect your email",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        MyEmailField(
          icon: CupertinoIcons.mail_solid,
          hintText: "name@example.com",
          controller: _emailController,
        ),
        const Gap(20.0),
        MyPasswordField(
          checkEye: _showPassword,
          onPressed: _togglePasswordVisibility,
          controller: _passwordController,
        ),
        const Gap(20.0),
        const Text(
          "Forget your Password?",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                "Sign up here",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyLogoButton(
          imgUrl: "https://cdn-icons-png.flaticon.com/128/0/747.png",
          title: "Apple",
        ),
        const Gap(20.0),
        MyLogoButton(
          imgUrl: "https://cdn-icons-png.flaticon.com/128/300/300221.png",
          title: "Google",
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          const Text(
            "By continuing you agree to loana's",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Terms of Use",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ),
              const Text(
                "&",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
