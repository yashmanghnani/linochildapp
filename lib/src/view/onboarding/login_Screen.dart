import 'package:flutter/material.dart';
import 'package:lino/src/view/widgets/login_widget/login_Widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/761024de7c9b02c2e56b214b89006ac73f42aba6.png",
              fit: BoxFit.fill,
            ),
          ),

          Center(child: LoginWidget()),
        ],
      ),
    );
  }
}
