import 'package:flutter/material.dart';

class LetsTalkScreen extends StatelessWidget {
  const LetsTalkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/5154fe87c6d7306d7d944d635b4ede01da1e9cdd.png',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/lino_0.png',
              width: size.width * 0.4,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
