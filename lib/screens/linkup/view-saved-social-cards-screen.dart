import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/dropdown-menu.dart';
import 'package:the_wallet/Screens/components/navbar.dart';
import 'package:the_wallet/Screens/components/social-card.dart';
import 'package:the_wallet/Screens/linkup/social-card-template.dart';

class SavedSocialCard extends StatefulWidget {
  @override
  SavedSocialCardState createState() => SavedSocialCardState();
}

class SavedSocialCardState extends State<SavedSocialCard> {
  bool _isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  Widget buildDividerMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 1,
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
                var begin = const Offset(-1.0, 0.0);
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: linkUpMain,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 90, bottom: 100),
                      child: Column(
                        children: [
                          SocialCardTemplate(
                            socialCard: SocialCard(
                              firstName: 'John',
                              lastName: 'Doe',
                              career: 'Software Engineer',
                              age: '30',
                              email: 'john.doe@example.com',
                              phoneNumber: '+1 (123) 456-7890',
                              linkedIn: 'https://www.linkedin.com/in/johndoe/',
                              twitter: 'https://twitter.com/johndoe/',
                              instagram: 'https://www.instagram.com/johndoe/',
                              facebook: 'https://www.facebook.com/johndoe/',
                              picture: null,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 20),
                          ),
                          SocialCardTemplate(
                            socialCard: SocialCard(
                              firstName: 'John',
                              lastName: 'Doe',
                              career: 'Software Engineer',
                              age: '30',
                              email: 'john.doe@example.com',
                              phoneNumber: '+1 (123) 456-7890',
                              linkedIn: 'https://www.linkedin.com/in/johndoe/',
                              twitter: 'https://twitter.com/johndoe/',
                              instagram: 'https://www.instagram.com/johndoe/',
                              facebook: 'https://www.facebook.com/johndoe/',
                              picture: null,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 20),
                          ),
                          SocialCardTemplate(
                            socialCard: SocialCard(
                              firstName: 'John',
                              lastName: 'Doe',
                              career: 'Software Engineer',
                              age: '30',
                              email: 'john.doe@example.com',
                              phoneNumber: '+1 (123) 456-7890',
                              linkedIn: 'https://www.linkedin.com/in/johndoe/',
                              twitter: 'https://twitter.com/johndoe/',
                              instagram: 'https://www.instagram.com/johndoe/',
                              facebook: 'https://www.facebook.com/johndoe/',
                              picture: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DropDown(
              bottomPadding: 20,
              topBarColor: linkUpMain,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: linkUpMain,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Navbar(currentPage: 'linkup'),
            ),
          ],
        ),
      ),
    );
  }
}
