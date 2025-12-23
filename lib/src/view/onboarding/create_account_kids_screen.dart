import 'package:flutter/material.dart';
import 'package:lino/src/view/widgets/create_Account_widget/Create_account_kids_widget.dart';

class CreateAccountKidsScreen extends StatelessWidget {
  const CreateAccountKidsScreen({super.key});

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

          Center(child: CreateAccountKids()),
        ],
      ),
    );
  }
}
