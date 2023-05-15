import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/Screens/account/user.dart';
import 'package:the_wallet/Screens/account/account-edit-password-screen.dart';
import 'package:the_wallet/Screens/account/account-edit-screen.dart';

class AccountMain extends StatelessWidget {
  AccountMain({Key? key}) : super(key: key);

  Widget buildButton(BuildContext context, Widget page, String buttonText) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
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
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(256, 37)),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF888888),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Color(0xFF000000),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: accountMain,
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, left: 24),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: closeColor,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: secondaryColor,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: Color(0xB3000000),
                      child: user.picture == null
                          ? const Icon(Icons.person_rounded,
                              color: accountMain, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: FileImage(user.picture!),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                          color: tertiraryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        user.email,
                        style: const TextStyle(
                          color: tertiraryColor,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        user.userID,
                        style: const TextStyle(
                          color: Color(0xAA424242),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    buildButton(context, const AccountEditProfile(), "Edit Profile"),
                    const SizedBox(height: 10),
                    buildButton(context, const AccountEditPassowrd(), "Change Password"),
                    const SizedBox(height: 170),
                  ],
                ),
              ),
              BottomButtons(
                leftButtonBackgroundColor: const Color(0x5AFF0000),
                leftButtonIcon: Icons.delete,
                leftButtonIconColor: linkUpMain,
                onLeftButtonPressed: () {},
                onRightButtonPressed: () {},
                rightButtonBackgroundColor: const Color(0x5AFF0000),
                rightButtonIcon: Icons.logout,
                rightButtonText: "Logout",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
