import 'package:flutter/material.dart';

class BabyPageWidget extends StatefulWidget {
  const BabyPageWidget({super.key});

  @override
  State<BabyPageWidget> createState() => _BabyPageWidgetState();
}

class _BabyPageWidgetState extends State<BabyPageWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Center(
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          // height: size.height * 0.65,
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.038),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.14,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0XFFF6E4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Color(0XFFAF52DE), size: 25),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Color(0XFFAF52DE),
                            fontFamily: 'Baloo2',
                            fontWeight: .bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.14,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0XFFF6E4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: Color(0XFFAF52DE),
                          size: 25,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          'Terms and Condition',
                          style: TextStyle(
                            color: Color(0XFFAF52DE),
                            fontFamily: 'Baloo2',
                            fontWeight: .bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.14,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0XFFF6E4FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever,
                          color: Color(0XFFAF52DE),
                          size: 25,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Color(0XFFAF52DE),
                            fontFamily: 'Baloo2',
                            fontWeight: .bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
