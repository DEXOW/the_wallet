import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/account_edit_screen.dart';
import 'package:the_wallet/screens/account/account_main_screen.dart';
import 'package:the_wallet/screens/components/close_button_account.dart';
import 'package:the_wallet/screens/components/global.dart';

class AccountEditPhone extends StatefulWidget {
  final String pictureUrl;
  const AccountEditPhone({Key? key, required this.pictureUrl})
      : super(key: key);

  @override
  AccountEditPhoneState createState() => AccountEditPhoneState();
}

class AccountEditPhoneState extends State<AccountEditPhone> {
  String phoneNo = '';
  bool isPhoneValid = false;
  String phoneValidationText = 'Please enter new phone number';
  Color phoneValidationColor = Colors.grey;

  String otp = '';
  String verificationID = '';
  TextEditingController otpController = TextEditingController();
  final int digitCount = 6;

  FirebaseAuth auth = FirebaseAuth.instance;

  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  bool showError = false;

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

  void updateOtpValue() {
    otp = otpController.text;
    if (otp.length == digitCount) {
      submitOtp(context, otp);
    } else {}
  }

  Future<void> submitOtp(BuildContext context, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: otp,
    );

    User? user = auth.currentUser;
    try {
      if (verificationID.isNotEmpty) {
        await user!.updatePhoneNumber(credential);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({
          'phoneNoCode': '+94',
          'phoneNo': phoneNo,
        });
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AccountMain(),
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
        }
      } else {
        SnackBarNotify.showSnackBar(
            context: context,
            message: "Invalid OTP",
            bgcolor: const Color(0xE61469EF),
            textColor: const Color(0xFFFFFFFF));
      }
    } on FirebaseAuthException {
      rethrow;
    }
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
                    //**** PHONE NUMBER ****//
                    Row(
                      children: [
                        const Text(
                          'Phone Number',
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
                                phoneNo = value;
                                phoneValidationColor = Colors.red;
                                isPhoneValid = false;
                                if (phoneNo.isEmpty) {
                                  phoneValidationText = 'Can\'t be empty';
                                } else if (!RegExp(r'^(0|)\d{9}$')
                                    .hasMatch(phoneNo)) {
                                  phoneValidationText = 'Invalid Phone Number';
                                } else {
                                  phoneValidationText = 'Valid Phone Number';
                                  phoneValidationColor = Colors.green;
                                  isPhoneValid = true;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isPhoneValid
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
                        phoneValidationText,
                        style: TextStyle(
                          color: phoneValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextButton(
                        onPressed: () async {
                          if (isPhoneValid) {
                            await auth.verifyPhoneNumber(
                              phoneNumber: '+94$phoneNo',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                verificationID = verificationId;
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          }
                        },
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
                    const SizedBox(height: 20),
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
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
