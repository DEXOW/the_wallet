import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/close_button_account.dart';
import 'package:the_wallet/screens/components/global.dart';
import 'package:the_wallet/screens/components/navbar_top_account.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/account/account_edit_password_screen.dart';
import 'package:the_wallet/screens/account/account_edit_screen.dart';
import 'package:the_wallet/screens/startup/startup_screen.dart';

import '../login/login_screen.dart';

class AccountMain extends StatelessWidget {
  AccountMain({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  void navigator(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    Widget buildButton(BuildContext context, Widget page, String buttonText) {
      return TextButton(
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
      );
    }

    return Scaffold(
      backgroundColor: primaryAccountColor,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: primaryAccountColor,
          body: Stack(
            children: [
              buildCloseButton(context),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: const Color(0xB3000000),
                      child: userDataProvider.userData.pictureUrl == ""
                          ? const Icon(Icons.person_rounded,
                              color: primaryAccountColor, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: Image.network(
                                      userDataProvider.userData.pictureUrl!)
                                  .image,
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${userDataProvider.userData.fname} ${userDataProvider.userData.lname}",
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
                        userDataProvider.userData.email!,
                        style: const TextStyle(
                          color: tertiraryColor,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    buildButton(
                        context, const AccountEditProfile(), "Edit Profile"),
                    const SizedBox(height: 10),
                    buildButton(
                        context,
                        AccountEditPassowrd(
                          pictureUrl: userDataProvider.userData.pictureUrl!,
                        ),
                        "Change Password"),
                    const SizedBox(height: 170),
                  ],
                ),
              ),
              BottomButtons(
                leftButtonBackgroundColor: const Color(0x5AFF0000),
                leftButtonIcon: Icons.delete,
                leftButtonIconColor: linkUpMain,
                onLeftButtonPressed: () async {
                  final currentUser = auth.currentUser;
                  final bool? result = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: const Color(0xDDFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // buttonPadding: EdgeInsets.all(20),
                        actionsPadding: const EdgeInsets.only(bottom: 20),
                        contentPadding: const EdgeInsets.all(20),
                        titlePadding: const EdgeInsets.only(top: 20),
                        insetPadding: const EdgeInsets.all(40),
                        content: const Text(
                          'Are you sure you want to delete your account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        actions: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: linkUpMain,
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        child: const Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        style: const ButtonStyle(
                                          splashFactory: NoSplash.splashFactory,
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                        ),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: linkUpMain,
                                  ),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        style: const ButtonStyle(
                                          splashFactory: NoSplash.splashFactory,
                                          overlayColor:
                                              MaterialStatePropertyAll(
                                                  Colors.transparent),
                                        ),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (result == true) {
                    try {
                      await currentUser!.delete();
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('users');
                      await collection.doc(currentUser.uid).delete();
                      if (auth.currentUser == null) {
                        if (context.mounted) {
                          SnackBarNotify.showSnackBar(
                            context: context,
                            message:
                                "Your account has been successfully deleted",
                            bgcolor: const Color(0xE61469EF),
                            textColor: const Color(0xFFFFFFFF),
                          );
                          navigator(
                            context,
                            const StartupScreen(),
                          );
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'requires-recent-login') {
                        if (context.mounted) {
                          SnackBarNotify.showSnackBar(
                            context: context,
                            message:
                                "You must be recently logged in to delete your account. Please log back in to delete your account.",
                            bgcolor: const Color(0xE61469EF),
                            textColor: const Color(0xFFFFFFFF),
                          );
                          navigator(
                            context,
                            const LoginScreen(),
                          );
                        }
                      }
                    }
                  }
                },
                onRightButtonPressed: () async {
                  try {
                    await auth.signOut();
                    // auth.currentUser?.reload();
                    if (auth.currentUser == null) {
                      if (context.mounted) {
                        navigator(
                          context,
                          const LoginScreen(),
                        );
                      }
                    }
                  } catch (e) {
                    rethrow;
                  }
                },
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
