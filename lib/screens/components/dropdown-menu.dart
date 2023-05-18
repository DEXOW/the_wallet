import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/account/account-main-screen.dart';
import 'package:the_wallet/Screens/linkup/edit-social-card-screen.dart';
import 'package:the_wallet/Screens/linkup/view-saved-social-cards-screen.dart';
import 'package:the_wallet/Screens/linkup/view-social-card-screen.dart';

class DropDown extends StatefulWidget {
  final double bottomPadding;
  final Color topBarColor;
  DropDown({required this.bottomPadding, required this.topBarColor});

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late double bottomPadding;
  late Color topBarColor;

  late AnimationController _controller;
  late Animation<double> _animation;

  Color _iconColor = linkUpMain;
  Color _containerColor = const Color(0xCCFFFFFF);

  @override
  void initState() {
    super.initState();
    bottomPadding = widget.bottomPadding;
    topBarColor = widget.topBarColor;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    initAnimation();
  }

  void initAnimation() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _iconColor = _isExpanded ? const Color(0xCCFFFFFF) : linkUpMain;
      _containerColor = _isExpanded ? linkUpMain : const Color(0xCCFFFFFF);
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget buildDividerMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 0.8,
        color: linkUpMain,
      ),
    );
  }

  Widget buildMenuItemButton(
    Widget page,
    String iconPath,
    String buttonText,
    double width,
  ) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = const Offset(0, 0.0);
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: linkUpMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(65),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Image.asset(
              iconPath,
              width: 35,
              height: 35,
            ),
            Expanded(
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(width: width),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItemHint(String hintText) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        hintText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: linkUpMain,
          fontWeight: FontWeight.w500,
          fontSize: 10,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 15, bottom: bottomPadding),
            decoration: BoxDecoration(color: topBarColor),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFFFFFFFF),
                  ),
                  onPressed: () {},
                  iconSize: 25.0,
                  color: _iconColor,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xCCFFFFFF),
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_rounded,
                      color: linkUpMain,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AccountMain(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, -1.0);
                            const end = Offset.zero;
                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            );
                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    iconSize: 20.0,
                    color: _iconColor,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 19,
          left: 23,
          right: 23,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
              width: 11,
              height: _animation.value * 570 + 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xF2B5B5BD),
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildMenuItemButton(EditSocialCard(), 'assets/icons/scan.png',
                        'Scan Another Social Card', 15),
                    const SizedBox(height: 10),
                    buildMenuItemHint(
                        'Scan another person’s social card via QR or NFC to view and/or store their social card into your account'),
                    const SizedBox(height: 10),
                    buildDividerMenu(),
                    const SizedBox(height: 25),
                    buildMenuItemButton(EditSocialCard(), 'assets/icons/edit_menu.png',
                        'Edit Your Own Social Card', 14),
                    const SizedBox(height: 10),
                    buildMenuItemHint(
                        'Edit your own social card details including personal details, social media links and profile pic'),
                    const SizedBox(height: 10),
                    buildDividerMenu(),
                    const SizedBox(height: 25),
                    buildMenuItemButton(ViewSocialCard(), 'assets/icons/view_menu.png',
                        'View Your Social Card', 20),
                    const SizedBox(height: 10),
                    buildMenuItemHint(
                        'View your social card to see how it will appear when someone else scans your QR code'),
                    const SizedBox(height: 10),
                    buildDividerMenu(),
                    const SizedBox(height: 25),
                    buildMenuItemButton(SavedSocialCard(), 'assets/icons/scan.png',
                        'View Saved Social Card(s)', 14),
                    const SizedBox(height: 10),
                    buildMenuItemHint(
                        'View all social cards of other people that you have scanned and saved to your account'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 25,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: _containerColor,
                radius: 20.0,
                child: IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: _iconColor,
                  ),
                  onPressed: () {
                    toggleExpand();
                  },
                  iconSize: 25.0,
                  color: _iconColor,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
