import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountParents extends StatefulWidget {
  const CreateAccountParents({super.key});

  @override
  State<CreateAccountParents> createState() => _CreateAccountParentsState();
}

class _CreateAccountParentsState extends State<CreateAccountParents> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _mailController;
  late TextEditingController _passwordController;

  String? selectedValue;
  String? selectedCountry;
  String? selectedCity;

  final Map<String, List<String>> citiesByCountry = {
    "India": ["Agra", "Delhi", "Mumbai", "Bangalore", "Gurgaon", "Faridabad"],
    "United States": ["New York", "Los Angeles", "Chicago"],
    "Russia": ["Moscow", "Saint Petersburg"],
    "China": ["Beijing", "Shanghai"],
    "Japan": ["Tokyo", "Osaka"],
    "United Kingdom": ["London", "Manchester"],
  };

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _mailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.95,
          // maxHeight: size.height * 0.95,
        ),
        child: Container(
          // width: size.width * 0.95,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.028, // Reduced from 0.03
          ),
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
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
                          color: Colors.purple,
                          // border: Border.all(color: Colors.purple, width: 2),
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
                            color: Colors.transparent,
                            border: Border.all(color: Colors.purple, width: 2),
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
                    "Parent's Information ",
                    style: TextStyle(
                      color: Color(0XFFAF52DE),
                      fontFamily: 'Baloo2',
                      fontSize: size.width * 0.016,
                      fontWeight: .bold,
                    ),
                  ),
                  SizedBox(width: size.width * 0.44, child: Divider()),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: DropdownButtonFormField<String>(
                            isDense: true,
                            initialValue: selectedValue,
                            decoration: InputDecoration(
                              labelText: "select who you are?",
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
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),

                            items: ["Mother", "Father", "Siblings"].map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
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
                      SizedBox(width: size.width * 0.02),
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Enter Your Name",
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
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
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
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: DropdownButtonFormField<String>(
                            isDense: true,
                            initialValue: selectedCountry,
                            decoration: InputDecoration(
                              labelText: 'Select Country',
                              labelStyle: const TextStyle(
                                color: Color(0XFFAEB7BF),
                              ),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 215, 218, 220),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 215, 218, 220),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                            menuMaxHeight: 300,
                            elevation: 8,
                            borderRadius: BorderRadius.circular(16),
                            dropdownColor: Colors.white,

                            items:
                                [
                                      "India",
                                      "United States",
                                      "Russia",
                                      "China",
                                      "Japan",
                                      "United Kingdom",
                                    ]
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCountry = value;
                                selectedCity =
                                    null; // reset city when country changes
                              });
                            },

                            style: TextStyle(
                              // fontSize: size.width * 0.0114,
                              // fontWeight: .bold,
                              color: Colors.black,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0XFFAEB7BF),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: size.width * 0.004),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: DropdownButtonFormField<String>(
                            isDense: true,
                            initialValue: selectedCity,
                            decoration: InputDecoration(
                              labelText: 'Select City',
                              labelStyle: const TextStyle(
                                color: Color(0XFFAEB7BF),
                              ),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 215, 218, 220),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 215, 218, 220),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                            items: selectedCountry == null
                                ? []
                                : (citiesByCountry[selectedCountry] ?? [])
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value;
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
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0XFFAEB7BF),
                            ),
                          ),
                        ),
                      ),

                      // Country Dropdown
                      SizedBox(width: size.width * 0.02),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: TextField(
                            controller: _phoneController,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // Only allows digits (0-9)
                            ],
                            // maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Enter Phone Number",
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
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
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
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.115,
                          child: TextField(
                            controller: _mailController,
                            decoration: InputDecoration(
                              labelText: "Enter Mail",
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
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
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
                              labelText: "Enter Password",
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
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
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
                  SizedBox(height: size.height * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                                  Navigator.pushNamed(context, "/login");
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedCountry == null ||
                            selectedCountry!.isEmpty ||
                            selectedCity == null ||
                            selectedCity!.isEmpty ||
                            selectedValue == null ||
                            selectedValue!.isEmpty ||
                            _nameController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _mailController.text.isEmpty) {
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
                              ),
                              shape: StadiumBorder(),
                              elevation: 6,
                            ),
                          );
                          return;
                        }

                        if (_phoneController.text.length < 10 ||
                            _phoneController.text.length > 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Phone Number should be 10 Numbers only',
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
                        if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(_mailController.text.trim())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter a valid email address',
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
                        String password = _passwordController.text;
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
                              ), 
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
                              ), 
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
                              ), 
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
                              ), 
                              shape: StadiumBorder(),
                              elevation: 6,
                            ),
                          );
                          return;
                        }
                        // if (!RegExp(
                        //   r'[!@#$%^&*(),.?":{}|<>]',
                        // ).hasMatch(password)) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         'Password must contain a special character',
                        //       ),
                        //       backgroundColor: Colors.red,
                        //     ),
                        //   );
                        //   return;
                        // }

                        Navigator.pushNamed(context, "/createaccountkid");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFAF52DE),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.014,
                          horizontal: size.width * 0.085,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 4,
                      ),
                      child: Text("Next"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
