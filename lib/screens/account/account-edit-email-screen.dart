import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/screens/account/user.dart';
import 'package:the_wallet/screens/account/account-edit-screen.dart';

class AccountEditEmail extends StatefulWidget {
  const AccountEditEmail({Key? key}) : super(key: key);

  @override
  AccountEditEmailState createState() => AccountEditEmailState();
}

class AccountEditEmailState extends State<AccountEditEmail> {
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String email = '';
  String verifyEmail = '';
  bool isEmailValid = false;
  bool isVerifyEmailValid = false;
  String emailValidationText = 'Please enter new email';
  String emailVerifyValidationText = 'Please verify new email';
  Color emailValidationColor = Colors.grey;
  Color emailVerifyValidationColor = Colors.grey;

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
      body: SafeArea(
        child: Scaffold(
          backgroundColor: accountMain,
          body: Stack(
            children: [
              //**** CLOSE ICON ****//
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
              Container(
                margin: const EdgeInsets.only(bottom: 140, left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //**** PROFILE ICON SECTION ****//
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: const Color(0xB3000000),
                      child: user.picture == null
                          ? const Icon(Icons.person_rounded,
                              color: accountMain, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: FileImage(user.picture!),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        user.userID,
                        style: const TextStyle(
                          color: Color(0xAA424242),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                                // validate email input using regex
                                isEmailValid = emailRegex.hasMatch(value);

                                // set validation display and icon based on email input
                                if (value.isEmpty) {
                                  emailValidationText = 'Enter email';
                                  emailValidationColor = Colors.red;
                                } else if (isEmailValid) {
                                  emailValidationText = 'Valid email';
                                  emailValidationColor = Colors.green;
                                } else {
                                  emailValidationText = 'Invalid email';
                                  emailValidationColor = Colors.red;
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
                    SizedBox(
                      width: double.infinity,
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
                    const SizedBox(height: 5),
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
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                verifyEmail = value;
                                // validate verify email input
                                isVerifyEmailValid = email == verifyEmail;

                                // set validation display and icon based on email input
                                if (value.isEmpty) {
                                  emailVerifyValidationText =
                                      'Enter the same email';
                                  emailVerifyValidationColor = Colors.red;
                                } else if (isVerifyEmailValid) {
                                  emailVerifyValidationText =
                                      'Emails are matching';
                                  emailVerifyValidationColor = Colors.green;
                                } else {
                                  emailVerifyValidationText =
                                      'Emails do not match';
                                  emailVerifyValidationColor = Colors.red;
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
                      margin: const EdgeInsets.only(left: 2),
                      child: SizedBox(
                        width: double.infinity,
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
                    ),
                    //**** REQUEST VERIFICATION BUTTON ****//
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(256, 37)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xD3A1A1A1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Request Verification Link",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        textAlign: TextAlign.center,
                        "A verification link will be sent to your email shortly, click on it inorder to verify your email",
                        style: TextStyle(
                          color: Color.fromARGB(255, 102, 102, 102),
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
                leftButtonBackgroundColor: closeColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  navigateToPage(context, AccountEditProfile());
                },
                onRightButtonPressed: () {},
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
