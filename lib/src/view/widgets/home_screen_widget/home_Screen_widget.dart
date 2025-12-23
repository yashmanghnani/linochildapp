import 'package:flutter/material.dart';
import 'package:lino/src/view/widgets/home_screen_widget/baby_page_widget.dart';
import 'package:lino/src/view/widgets/home_screen_widget/gift_page_widget.dart';
import 'package:lino/src/view/widgets/home_screen_widget/home_page_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Column(
          children: [
            _buildTopBar(size),
            SizedBox(height: size.height * 0.05),

            SizedBox(
              height: size.height * 0.6,
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  Center(child: HomePageWidget()),
                  GiftPageWidget(),
                  BabyPageWidget(),
                ],
              ),
            ),
          ],
        ),

        if (_toggle)
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Untitled design (2).gif',
                    fit: BoxFit.fill,
                  ),
                ),

                Positioned(
                  top: size.height * 0.020,
                  right: size.width * 0.020,
                  child: Switch(
                    value: _toggle,
                    onChanged: (v) {
                      setState(() {
                        _toggle = v;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTopBar(Size size) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.translate(
              offset: Offset(-size.width * 0.020, 0),
              child: Image.asset(
                'assets/images/Remove background fr.png',
                height: size.height * 0.12,
                width: size.width * 0.25,
              ),
            ),
            Transform.translate(
              offset: Offset(-size.width * 0.080, 0),
              child: Switch(
                value: _toggle,
                onChanged: (v) {
                  setState(() {
                    _toggle = v;
                  });
                },
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Transform.translate(
            offset: Offset(-size.width * 0.03, 0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(22),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.003),
                child: Container(
                  height: size.height * 0.16,
                  width: size.width * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.0080),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _navItem(
                            label: "HOME",
                            icon: Icons.home_filled,
                            page: 0,
                            size: size,
                          ),
                          _navItem(
                            label: "GIFTS",
                            icon: Icons.card_giftcard_rounded,
                            page: 1,
                            size: size,
                          ),
                          _navItem(
                            label: "BABY",
                            image: 'assets/images/image.png',
                            page: 2,
                            size: size,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem({
    Size? size,
    required String label,
    IconData? icon,
    String? image,
    required int page,
  }) {
    final bool isActive = _currentIndex == page;

    return InkWell(
      onTap: () {
        _controller.jumpToPage(page);

        // _controller.animateToPage(
        //   page,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        // // setState(() {
        // //   _currentIndex = page;
        // // });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? const Color(0XFFAF52DE) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size!.width * 0.008,
          vertical: size.height * 0.016,
        ),
        child: Column(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0XFFAF52DE),
                size: 25,
              )
            else
              CircleAvatar(radius: 12, backgroundImage: AssetImage(image!)),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0XFFAF52DE),
                fontSize: size.width * 0.013,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
