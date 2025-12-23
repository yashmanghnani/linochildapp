import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/761024de7c9b02c2e56b214b89006ac73f42aba6.png",
              fit: BoxFit.fill,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/Remove the backgroun.png",
                  width: size.width * 0.40,
                  height: size.height * 0.35,
                ),

                Text(
                  "Welcome to Lino!",
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Baloo2',
                    color: Color(0XFF07313D),
                    height: 0.9,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: size.height * 0.05),

                Text(
                  'Play, Learn, and Explore with\n Exciting Games!',
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.034,
                    color: Color(0XFF07313D),
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: size.height * 0.05),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/createaccountParent");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF07323E),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Get In', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
