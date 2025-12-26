// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lino/src/controller/AiCallController.dart';
import 'package:lino/src/view/widgets/app_Audio_Service.dart';
import 'package:state_extended/state_extended.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  StateX<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends StateX<HomePageWidget> {
  late Aicallcontroller con;

  _HomePageWidgetState()
    : super(
        controller: Aicallcontroller(),
        useInherited: true,
        debugPrintEvents: true,
      ) {
    con = controller as Aicallcontroller;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // App minimized / backgrounded
      debugPrint("App paused → stop AI & audio");
      con.shutdownAI(); // stop speech, audio, socket
    } else if (state == AppLifecycleState.resumed) {
      AppAudioService().startBackgroundSound(); 
      // App back to foreground
      debugPrint("App resumed → user can tap Play Now to start fresh");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      itemCount: 2,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        List<String> headings = ["Let's Talk", 'Play Modes'];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              // height: size.height * 0.2,
              width: size.width * 0.39,
              decoration: BoxDecoration(
                color: Color(0XFFF2D7FF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    left: size.width * 0.24,
                    // top: size.height * 0.0009,
                    bottom: size.height * 0.20,
                    child: Container(
                      height: size.height * 0.33,
                      width: size.width * 0.20,
                      decoration: BoxDecoration(
                        color: Color(0XFFE9C4FA),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: size.height * 0.32,
                    // left: size.width * 0.0001,
                    right: size.width * 0.35,
                    child: Container(
                      height: size.height * 0.38,
                      width: size.width * 0.07,
                      decoration: BoxDecoration(
                        color: Color(0XFFE9C4FA),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -size.height * 0.01,
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.3,
                      child: Image.asset(
                        'assets/images/Vector 554.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: size.height * 0.059,
                    right: size.width * 0.20,
                    child: SizedBox(
                      height: size.height * 0.40,
                      width: size.width * 0.21,
                      child: Image.asset(
                        'assets/images/9491a19375cdc65eaa7b1f5473b839630605e6ec.png',
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.22,
                    top: size.height * 0.32,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: InkWell(
                        onTap: () async {
                          if (index == 0) {
                            await con.startDirectAICall("user2");
                            Navigator.pushNamed(context, "/letsTalk");
                          }
                        },
                        child: Container(
                          height: size.height * 0.12,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                              /* Rectangle 15 */

                              // position: absolute;
                              // left: 53.35%;
                              // right: 6.37%;
                              // top: 52.36%;
                              // bottom: 22.18%;

                              // background: linear-gradient(180deg, #33F0B0 0%, #0D8AFC 100%);
                              // border-radius: 20px;
                              colors: [
                                Color(0xFFFFFFFF), // start color (#FFFFFF)
                                Color(0xFFAF52DE),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              index == 0 ? ' Play Now' : 'Learn Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Baloo2',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.21,
                    right: size.width * 0.017,
                    child: Text(
                      headings[index],
                      style: TextStyle(
                        color: Color(0XFF251504),
                        fontFamily: 'Baloo2',
                        fontSize: size.width * 0.026,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
