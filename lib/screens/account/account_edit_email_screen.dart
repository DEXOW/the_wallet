import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/account_edit_screen.dart';
import 'package:the_wallet/screens/account/account_main_screen.dart';
import 'package:the_wallet/screens/components/close_button_account.dart';
import 'package:the_wallet/screens/components/navbar_top_account.dart';

class AccountEditEmail extends StatefulWidget {
  final String pictureUrl;
  const AccountEditEmail({Key? key, required this.pictureUrl})
      : super(key: key);

  @override
  AccountEditEmailState createState() => AccountEditEmailState();
}

class AccountEditEmailState extends State<AccountEditEmail> {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String email = '';
  String verifyEmail = '';
  String password = '';
  bool isEmailValid = false;
  bool isVerifyEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;
  String emailValidationText = 'Please enter new email';
  String emailVerifyValidationText = 'Please verify new email';
  String passwordValidationText = 'Please enter the password for your account';
  Color emailValidationColor = Colors.grey;
  Color emailVerifyValidationColor = Colors.grey;

  FirebaseAuth auth = FirebaseAuth.instance;

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.0, 0.0);
          var end = const Offset(0, 0.0);
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryAccountColor,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: primaryAccountColor,
          body: Stack(
            children: [
              //**** CLOSE ICON ****//
              buildCloseButton(context),
              Container(
                margin: const EdgeInsets.only(top: 125, left: 30, right: 30),
                child: Column(
                  children: [
                    //**** PROFILE ICON ****//
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: const Color(0xB3000000),
                      child: widget.pictureUrl == ""
                          ? const Icon(Icons.person_rounded,
                              color: primaryAccountColor, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                                  Image.network(widget.pictureUrl).image,
                            ),
                    ),
                    const SizedBox(height: 35),
                    //**** EMAIL INPUT ****//
                    Row(
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: tertiraryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            cursorColor: tertiraryColor,
                            cursorOpacityAnimates: true,
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xBFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;

                                if (email.isEmpty) {
                                  emailValidationText = 'Enter email';
                                  emailValidationColor = Colors.red;
                                  isEmailValid = false;
                                } else if (emailRegex.hasMatch(email)) {
                                  emailValidationText = 'Valid email';
                                  emailValidationColor = Colors.green;
                                  isEmailValid = true;
                                } else {
                                  emailValidationText = 'Invalid email';
                                  emailValidationColor = Colors.red;
                                  isEmailValid = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isEmailValid
                            ? const Icon(Icons.check,
                                color: Colors.green, size: 20)
                            : const Icon(Icons.clear,
                                color: Colors.red, size: 20),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        emailValidationText,
                        style: TextStyle(
                          color: emailValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //**** VERIFY EMAIL INPUT ****//
                    Row(
                      children: [
                        const Text(
                          'Verify Email',
                          style: TextStyle(
                            color: tertiraryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            cursorColor: tertiraryColor,
                            cursorOpacityAnimates: true,
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xBFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                verifyEmail = value;

                                if (value.isEmpty) {
                                  emailVerifyValidationText =
                                      'Enter the same email';
                                  emailVerifyValidationColor = Colors.red;
                                  isVerifyEmailValid = false;
                                } else if (verifyEmail == email) {
                                  emailVerifyValidationText =
                                      'Emails are matching';
                                  emailVerifyValidationColor = Colors.green;
                                  isVerifyEmailValid = true;
                                } else {
                                  emailVerifyValidationText =
                                      'Emails do not match';
                                  emailVerifyValidationColor = Colors.red;
                                  isVerifyEmailValid = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isVerifyEmailValid
                            ? const Icon(Icons.check,
                                color: Colors.green, size: 20)
                            : const Icon(Icons.clear,
                                color: Colors.red, size: 20),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        emailVerifyValidationText,
                        style: TextStyle(
                          color: emailVerifyValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //**** PASSWORD ****//
                    Row(
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: tertiraryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            cursorColor: tertiraryColor,
                            cursorOpacityAnimates: true,
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            obscureText: !isPasswordVisible,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xBFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;

                                if (password.isEmpty) {
                                  isPasswordValid = false;
                                } else {
                                  isPasswordValid = true;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye_rounded,
                            size: 20,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        passwordValidationText,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //**** BOTTOM BAR ****//
              BottomButtons(
                leftButtonBackgroundColor: closeBackColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AccountEditProfile(),
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
                onRightButtonPressed: () async {
                  User? user = auth.currentUser;

                  if (isEmailValid && isVerifyEmailValid && isPasswordValid) {
                    //Retirieve email from firestore
                    final snapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .snapshots()
                        .first;
                    final userData = snapshot.data();
                    final oldEmail = userData!['email'];

                    //Reauthenticate the user with old credientials
                    try {
                      UserCredential userCredential =
                          await user!.reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                            email: oldEmail, password: password),
                      );

                      //Update the user with the new email in firebase authentication
                      await userCredential.user!.updateEmail(email);

                      //Update the user with the new email in firebase firestore
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(auth.currentUser!.uid)
                          .update(
                        {
                          'email': email,
                        },
                      );
                      if (context.mounted) {
                        navigateToPage(context, AccountMain());
                      }
                    } catch (e) {
                      rethrow;
                    }
                  }
                },
                rightButtonBackgroundColor: const Color(0x6024FF00),
                rightButtonIcon: Icons.check_rounded,
                rightButtonText: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
