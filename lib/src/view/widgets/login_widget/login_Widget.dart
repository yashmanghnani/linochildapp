import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _passwordController;
  late TextEditingController _mailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _mailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Container(
        width: size.width * 0.95,
        // height: size.height * 0.90,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log In',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontWeight: .bold,
                fontSize: size.width * 0.032,
              ),
            ),
            SizedBox(width: size.width * 0.44, child: Divider()),
            SizedBox(height: size.height * 0.05),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.115,
                    child: TextField(
                      controller: _mailController,
                      decoration: InputDecoration(
                        labelText: 'Email/Phone Number',
                        labelStyle: TextStyle(color: Color(0XFFAEB7BF)),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 215, 218, 220),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 215, 218, 220),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                        // fontSize: size.width * 0.0114,
                        // fontWeight: .bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.115,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0XFFAEB7BF)),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 215, 218, 220),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 215, 218, 220),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                        // fontSize: size.width * 0.0114,
                        // fontWeight: .bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final String mailInput = _mailController.text.trim();
                    final String password = _passwordController.text;

                    if (mailInput.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill the required fields correctly',
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ), // optional: add margin
                          shape: StadiumBorder(),
                          elevation: 6,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    bool isPhone = RegExp(r'^[0-9]+$').hasMatch(mailInput);

                    if (isPhone) {
                      if (mailInput.length != 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Phone number must be 10 digits'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ), 
                            shape: StadiumBorder(),
                            elevation: 6,
                          ),
                        );
                        return;
                      }
                    } else {
                      if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(mailInput)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter a valid email address'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ), 
                            shape: StadiumBorder(),
                            elevation: 6,
                          ),
                        );
                        return;
                      }
                    }

                    if (password.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Password must be at least 8 characters',
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ), // optional: add margin
                          shape: StadiumBorder(),
                          elevation: 6,
                        ),
                      );
                      return;
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Password must contain uppercase letter',
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ), // optional: add margin
                          shape: StadiumBorder(),
                          elevation: 6,
                        ),
                      );
                      return;
                    }
                    if (!RegExp(r'[a-z]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Password must contain lowercase letter',
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ), // optional: add margin
                          shape: StadiumBorder(),
                          elevation: 6,
                        ),
                      );
                      return;
                    }
                    if (!RegExp(r'[0-9]').hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password must contain a number'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ), // optional: add margin
                          shape: StadiumBorder(),
                          elevation: 6,
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login successful!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ), // optional: add margin
                        shape: StadiumBorder(),
                        elevation: 6,
                      ),
                    );
                    Navigator.pushNamed(context, "/Home");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFAF52DE),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.020,
                      horizontal: size.width * 0.090,
                    ),
                  ),
                  child: Text('Log In', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By creating an account, you agree to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.020,
                      fontFamily: 'Baloo2',
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          fontFamily: 'Baloo2',
                          color: Color(0XFFAF52DE),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: " and \n",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Baloo2',
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          fontFamily: 'Baloo2',
                          color: Color(0XFFAF52DE),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: ".",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "New Account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.020,
                      fontFamily: 'Baloo2',
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontFamily: 'Baloo2',
                          color: Color(0XFFAF52DE),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                              context,

                              "/createaccountParent",
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
