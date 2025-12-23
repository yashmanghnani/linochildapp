import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lino/src/view/dashboard/home_screen.dart';
import 'package:lino/src/view/onboarding/login_Screen.dart';

class CreateAccountKids extends StatefulWidget {
  const CreateAccountKids({super.key});

  @override
  State<CreateAccountKids> createState() => _CreateAccountKidsState();
}

class _CreateAccountKidsState extends State<CreateAccountKids> {
  // final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? selectedGender;
  String? selectedMonth;
  String? selectedYear;

  final List<String> years = List.generate(
    80,
    (index) => (2025 - index).toString(),
  );

  @override
  void dispose() {
    _nameController.dispose();
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          // key: _formkey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: size.width * 0.027,
                        fontFamily: 'Baloo2',
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.09,
                    height: size.height * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.purple, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/images/236f8515fdc736b57f7295d7752df5adfc9b7b83.png",
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-size.width * 0.025, 0),
                    child: Container(
                      height: size.height * 0.005,
                      width: size.width * 0.02,
                      color: Colors.purple,
                    ),
                  ),
                  // Image.asset("assets/images/Line 1.png"),
                  Transform.translate(
                    offset: Offset(-size.width * 0.050, 0),
                    child: Container(
                      width: size.width * 0.09,
                      height: size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/images/08450cc0bf9bc78c55180fd2cb660ff11cc2db49.png",
                        width: size.width * 0.050,
                        height: size.height * 0.050,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Kids's Information ",
                style: TextStyle(
                  color: Color(0XFFAF52DE),
                  fontFamily: 'Baloo2',
                  fontSize: size.width * 0.016,
                  fontWeight: .bold,
                ),
              ),
              SizedBox(width: size.width * 0.44, child: Divider()),
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.115,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Enter Kid's Name",
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter kid\'s name';
                        //   }
                        //   if (value.length < 2) {
                        //     return 'Name must be at least 2 Characters';
                        //   }
                        //   if (!!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        //     return 'Name can only contain letters';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.115,
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        initialValue: selectedGender,
                        decoration: InputDecoration(
                          labelText: "Select Gender",
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

                        items: ["Male", "Female", "Others"].map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },

                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select gender';
                        //   }
                        //   return null;
                        // },
                        menuMaxHeight: 300,
                        elevation: 8,
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Colors.white,

                        style: TextStyle(
                          // fontSize: size.width * 0.0114,
                          // fontWeight: .bold,
                          color: Colors.black,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0XFFAEB7BF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.115,
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        initialValue: selectedMonth,
                        decoration: InputDecoration(
                          labelText: 'Select Month',
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
                        items:
                            [
                              "January",
                              "February",
                              "March",
                              "April",
                              "May",
                              "June",
                              "July",
                              "August",
                              "September",
                              "October",
                              "November",
                              "December",
                            ].map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select month';
                        //   }
                        //   return null;
                        // },
                        menuMaxHeight: 300,
                        elevation: 8,
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Colors.white,

                        style: TextStyle(
                          // fontSize: size.width * 0.0114,
                          // fontWeight: .bold,
                          color: Colors.black,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0XFFAEB7BF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.115,
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        initialValue: selectedYear,
                        decoration: InputDecoration(
                          labelText: 'Select Year',
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
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        items: years.map((year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedYear = value;
                          });
                        },

                        menuMaxHeight: 300,
                        elevation: 8,
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Colors.white,

                        style: TextStyle(
                          // fontSize: size.width * 0.0114,
                          // fontWeight: .bold,
                          color: Colors.black,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0XFFAEB7BF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (selectedGender == null ||
                          selectedGender!.isEmpty ||
                          selectedMonth == null ||
                          selectedMonth!.isEmpty ||
                          selectedYear == null ||
                          selectedYear!.isEmpty ||
                          _nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please fill all required fields correctly',
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

                      if (_nameController.text.length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Name must have atleast 2 characters!',
                            ),
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
                      if (_nameController.text.length > 50) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Name is too long!'),
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

                      if (!RegExp(
                        r'^[a-zA-Z ]+$',
                      ).hasMatch(_nameController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Name can contain letters only!'),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Account Created successfully!'),
                          backgroundColor: Colors.green,
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

                      Navigator.pushNamed(context, "/Home");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFAF52DE),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.03,
                        horizontal: size.width * 0.162,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(28),
                      ),
                      elevation: 4,
                    ),
                    child: Text("Create Account"),
                  ),
                  SizedBox(width: size.width * 0.02),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.018,
                        fontFamily: 'Baloo2',
                      ),
                      children: [
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  SizedBox(width: size.width * 0.001),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By creating an account, you agree to ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.017,
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
            ],
          ),
        ),
      ),
    );
  }
}
