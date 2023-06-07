// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:the_wallet/firebase/fire_auth.dart';
import 'package:the_wallet/screens/register/successful-screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';



class OtpScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  const OtpScreen({Key? key, required this.controllers}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late TextEditingController otpController;
  // late List<String> otpDigits;
  final int digitCount = 6;
  late bool otpFilled;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    // otpDigits = List<String>.generate(digitCount, (index) => "");
    otpFilled = false;
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 60,
      margin: EdgeInsets.only(top: 60),
      textStyle: TextStyle(
        fontSize: 20, 
        color: Color(0xFFEAEFF3), 
        fontWeight: FontWeight.w600
      ),
      decoration: BoxDecoration(
        color: Color(0x5E606060),
        borderRadius: BorderRadius.circular(10),
      ),
    );
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
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Container(
                            child: Image(
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
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
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
                              child: Pinput(
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              controller: otpController,
                              onChanged: (value){updateOtpValue();},
                            ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
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
                              margin: EdgeInsets.only(top: 5),
                              child: TextButton(
                                onPressed: () {
                                  FireAuth.verifyPhoneNumber(context: context, phoneNumber: widget.controllers[8].text + widget.controllers[9].text);
                                },
                                child: Text(
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
                              margin: EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Color(0x5E606060),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.only(left: 5),
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () {  
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (otpFilled) 
                                      {
                                        PhoneAuthCredential credential = await FireAuth.submitOTP(context: context,otp: otpController.text, controllers: widget.controllers);
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SuccessScreen(controllers: widget.controllers,credential: credential)), (Route<dynamic> route) => route.isFirst);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        otpFilled == true ? Color(0xE61469EF) : Color(0x5E606060),
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
                                    child: Text(
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
                            margin: EdgeInsets.only(top: 10),
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

  void updateOtpValue() {
    final otp = otpController.text;
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
  // Widget buildDigitField() {
    // return Container(
    //   width: 40.0,
    //   height: 60.0,
    //   margin: EdgeInsets.only(top: 60, left: 4.0, right: 4.0),
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     color: Color(0x5E606060),
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: RawKeyboardListener(
    //     focusNode: otpFocusNodes2[index],
    //     onKey: (event) {
    //       if (event.logicalKey == LogicalKeyboardKey.backspace) {
    //         if (otpControllers[index].text.isEmpty && index > 0) {
    //           // Move focus to the previous field
    //           FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
    //         }
    //       }
    //     },
    //     child: TextField(
    //       controller: otpControllers[index],
    //       focusNode: otpFocusNodes[index],
    //       textAlign: TextAlign.center,
    //       keyboardType: TextInputType.number,
    //       maxLength: 1,
    //       decoration: InputDecoration(
    //         counterText: '',
    //         border: InputBorder.none
    //       ),
    //       onChanged: (value) {
    //         otpDigits[index] = value;
    //         if (value.isNotEmpty && index < digitCount - 1) {
    //           // Move focus to the next field
    //           FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
    //         }
    //         updateOtpValue();
    //       },
    //     ),
    //   ),
    // );
  // }

  

}