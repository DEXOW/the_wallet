import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wallet/firebase/fire_auth.dart';

import 'package:the_wallet/screens/startup/startup-screen.dart';


class SuccessScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final PhoneAuthCredential credential;
  const SuccessScreen({Key? key, required this.controllers, required this.credential}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
              body: FutureBuilder(
                future: FireAuth.registerUsingEmailPassword(
                  fname: widget.controllers[0].text, 
                  lname: widget.controllers[1].text, 
                  email: widget.controllers[2].text,
                  password: widget.controllers[3].text,
                  dob: widget.controllers[5].text,
                  phoneNoCode: widget.controllers[6].text,
                  phoneNo: widget.controllers[7].text,
                  phoneAuthCredential: widget.credential,
                  context: context,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done){
                    return SizedBox( //SizedBox to set the height and width of the Page
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  margin: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF0A7F46),
                                        size: 80,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: const Text(
                                          "Successful",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                            color: Color(0xFFAEAEAE),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartupScreen()), (route) => false);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            const Color(0xE61469EF),
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
                                          'Login',
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
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            );
          }
        ) 
      ),
    );
  }
}