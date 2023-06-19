import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/account_main_screen.dart';
import 'package:the_wallet/screens/components/close_button_account.dart';
import 'package:the_wallet/screens/login/login_screen.dart';

class AccountEditPassowrd extends StatefulWidget {
  final String pictureUrl;
  const AccountEditPassowrd({Key? key, required this.pictureUrl})
      : super(key: key);

  @override
  AccountEditPassowrdState createState() => AccountEditPassowrdState();
}

class AccountEditPassowrdState extends State<AccountEditPassowrd> {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String password = '';
  String verifyPassword = '';
  bool isPasswordValid = false;
  bool isVerifyPasswordValid = false;
  String passwordValidationText = 'Please enter new password';
  String passwordVerifyValidationText = 'Please enter the same new password';
  Color passwordValidationColor = Colors.grey;
  Color passwordVerifyValidationColor = Colors.grey;

  String otp = '';
  String verificationID = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otpController = TextEditingController();
  final int digitCount = 6;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

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

  final defaultPinTheme = PinTheme(
    width: 45,
    height: 60,
    margin: const EdgeInsets.only(top: 30),
    textStyle: const TextStyle(
        fontSize: 20, color: tertiraryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: const Color(0x5E606060),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  Future<void> submitOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );
      if (verificationID.isEmpty) {
      } else {
        final user = auth.currentUser;
        if (user != null && isPasswordValid && isVerifyPasswordValid) {
          await user.updatePassword(password).then(
            (_) async {
              try {
                await auth.signOut();
                // auth.currentUser?.reload();
                if (auth.currentUser == null) {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => route.isFirst,
                    );
                  }
                }
              } catch (e) {
                rethrow;
              }
            },
          );
        }
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }

  void updateOtpValue() {
    otp = otpController.text;
    if (otp.length == digitCount) {
      submitOtp(context, otp);
    } else {}
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
                              setState(
                                () {
                                  password = value;
                                  passwordValidationColor = Colors.red;
                                  isPasswordValid = false;

                                  if (password.isEmpty) {
                                    passwordValidationText = 'Can\'t be empty';
                                  } else if (password.length < 6) {
                                    passwordValidationText =
                                        'Length at least 6';
                                  } else if (!RegExp(r'(?=.*[A-Z])')
                                      .hasMatch(password)) {
                                    passwordValidationText =
                                        'At least 1 uppercase letter';
                                  } else if (!RegExp(r'(?=.*[a-z])')
                                      .hasMatch(password)) {
                                    passwordValidationText =
                                        'At least 1 lowercase letter';
                                  } else if (!RegExp(r'(?=.*\d)')
                                      .hasMatch(password)) {
                                    passwordValidationText = 'At least 1 digit';
                                  } else if (!RegExp(r'(?=.*\W)')
                                      .hasMatch(password)) {
                                    passwordValidationText =
                                        'At least 1 special character';
                                  } else {
                                    passwordValidationText =
                                        'Password is valid';
                                    passwordValidationColor = Colors.green;
                                    isPasswordValid = true;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isPasswordValid
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
                        passwordValidationText,
                        style: TextStyle(
                          color: passwordValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //**** VERIFY PASSWORD ****//
                    Row(
                      children: [
                        const Text(
                          'Verify Password',
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
                                verifyPassword = value;
                                passwordVerifyValidationColor = Colors.red;
                                isVerifyPasswordValid = false;

                                if (verifyPassword.isEmpty) {
                                  passwordVerifyValidationText =
                                      'Can\'t be empty';
                                } else if (verifyPassword != password) {
                                  passwordVerifyValidationText =
                                      'Must be the same as password';
                                } else {
                                  passwordVerifyValidationText =
                                      'Passwords are matching';
                                  passwordVerifyValidationColor = Colors.green;
                                  isVerifyPasswordValid = true;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isVerifyPasswordValid
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
                        passwordVerifyValidationText,
                        style: TextStyle(
                          color: passwordVerifyValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    //**** REQUEST OTP BUTTON ****//
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: TextButton(
                            onPressed: () async {
                              //Get the data from friestore for the phone number
                              final snapshotData = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(auth.currentUser!.uid)
                                  .snapshots()
                                  .first;
                              final userData = snapshotData.data();
                              final phoneNumber = userData!['phoneNoCode'] +
                                  userData['phoneNo'];

                              //Send the otp code to the phone number
                              await auth.verifyPhoneNumber(
                                phoneNumber: phoneNumber,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  verificationID = verificationId;
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(256, 37)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0x80A1A1A1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Request OTP",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //**** OTP ****//
                    Pinput(
                      length: digitCount,
                      defaultPinTheme: defaultPinTheme,
                      controller: otpController,
                      onChanged: (value) {
                        updateOtpValue();
                      },
                    ),
                  ],
                ),
              ),
              //**** BACK ICON ****//
              Positioned(
                bottom: 35,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: closeBackColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFFFFFF),
                    ),
                    onPressed: () {
                      navigateToPage(context, AccountMain());
                    },
                    iconSize: 24.0,
                    hoverColor: Colors.transparent,
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
