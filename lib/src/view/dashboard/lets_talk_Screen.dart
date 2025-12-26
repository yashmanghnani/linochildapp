// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lino/src/controller/AiCallController.dart';
import 'package:lino/src/view/widgets/app_Audio_Service.dart';
import 'package:state_extended/state_extended.dart';

class LetsTalkScreen extends StatefulWidget {
  const LetsTalkScreen({super.key});

  @override
  StateX<LetsTalkScreen> createState() => _LetsTalkScreenState();
}

class _LetsTalkScreenState extends StateX<LetsTalkScreen> {
  late Aicallcontroller con;

  _LetsTalkScreenState()
    : super(
        controller: Aicallcontroller(),
        useInherited: true,
        debugPrintEvents: true,
      ) {
    con = controller as Aicallcontroller;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        await con.shutdownAI(); 
        AppAudioService().startBackgroundSound();
        return true; // allow back navigation
      },
      child: Scaffold(
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
      ),
    );
  }
}
