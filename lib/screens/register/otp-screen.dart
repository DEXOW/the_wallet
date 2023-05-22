import 'package:flutter/material.dart';
import 'package:the_wallet/firebase/fire_auth.dart';
import 'package:the_wallet/screens/register/successful-screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';



class OtpScreen extends StatefulWidget {
  final String verificationId;
  final int? resendToken;
  final List<TextEditingController> controllers;
  const OtpScreen({Key? key, required this.verificationId, required this.resendToken, required this.controllers}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  late List<FocusNode> otpFocusNodes2;
  late List<String> otpDigits;
  final int digitCount = 6;
  late bool otpFilled;

  @override
  void initState() {
    super.initState();
    otpControllers = List<TextEditingController>.generate(digitCount, (index) => TextEditingController());
    otpFocusNodes = List<FocusNode>.generate(digitCount, (index) => FocusNode());
    otpFocusNodes2 = List<FocusNode>.generate(digitCount, (index) => FocusNode());
    otpDigits = List<String>.generate(digitCount, (index) => "");
    otpFilled = false;
  }

  @override
  void dispose() {
    for (var element in otpControllers) {
      element.dispose();
    }
    for (var element in otpFocusNodes) {
      element.dispose();
    }
    for (var element in otpFocusNodes2) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox( //SizedBox to set the height and width of the Page
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Container(
                            child: const Image(
                              image: AssetImage('assets/icons/icon.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Middle section
                      height: screenHeight * 0.8,
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Color(0xE608B4F8)
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: 
                                  //6 text boxes for OTP
                                  List.generate(digitCount, (index) => buildDigitField(index)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: const Text(
                                "Didn't recieve an OTP ?",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Color(0xFF636363),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0x5E606060),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.only(left: 5),
                                      icon: const Icon(Icons.arrow_back_ios),
                                      onPressed: () {  
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (otpFilled) 
                                      {
                                        submitOTP(otp: otpDigits.join(), verificationId: widget.verificationId, resendToekn: widget.resendToken);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        otpFilled == true ? const Color(0xE61469EF) : const Color(0x5E606060),
                                      ),
                                      shape:
                                          MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                      ),
                                      fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(190.0, 50.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    Container( //Bottom Section
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              'Legal',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Color(0x8FCDCDCD),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Color(0x8FCDCDCD),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ) 
      ),
    );
  }

  Widget buildDigitField(int index) {
    return Container(
      width: 40.0,
      height: 60.0,
      margin: const EdgeInsets.only(top: 60, left: 4.0, right: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0x5E606060),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: RawKeyboardListener(
        focusNode: otpFocusNodes2[index],
        onKey: (event) {
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            if (otpControllers[index].text.isEmpty && index > 0) {
              // Move focus to the previous field
              FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
            }
          }
        },
        child: TextField(
          controller: otpControllers[index],
          focusNode: otpFocusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none
          ),
          onChanged: (value) {
            otpDigits[index] = value;
            if (value.isNotEmpty && index < digitCount - 1) {
              // Move focus to the next field
              FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
            }
            updateOtpValue();
          },
        ),
      ),
    );
  }

  void updateOtpValue() {
    final otp = otpDigits.join();
    if (otp.length == digitCount) {
      // All digits entered
      setState(() {
        otpFilled = true;
      });
      // Perform further actions with the OTP value
    }else{
      setState(() {
        otpFilled = false;
      });
    }
  }

  void submitOTP({
    required String otp,
    required String verificationId,
    required int? resendToekn,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    try { 
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Invalid OTP',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          )
        );
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      throw Exception('Something went wrong');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'OTP Verified',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      )
    );
    await FireAuth.registerUsingEmailPassword(
      fname: widget.controllers[0].text, 
      lname: widget.controllers[1].text, 
      email: widget.controllers[2].text,
      password: widget.controllers[3].text,
      dobDate: widget.controllers[5].text,
      dobMonth: widget.controllers[6].text,
      dobYear: widget.controllers[7].text,
      phoneNoCode: widget.controllers[8].text,
      phoneNo: widget.controllers[9].text,
      phoneAuthCredential: credential,
    );


    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SuccessScreen()), (Route<dynamic> route) => route.isFirst);
  }
}