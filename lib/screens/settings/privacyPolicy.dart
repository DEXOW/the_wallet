// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:the_wallet/screens/settings/settings-screen.dart';

import '../components/navbar.dart';
import 'manage-wallet.dart';

class privacyPolicyScreen extends StatefulWidget {
  const privacyPolicyScreen({super.key});

  @override
  State<privacyPolicyScreen> createState() => _privacyPolicyScreenState();
}

class _privacyPolicyScreenState extends State<privacyPolicyScreen> {
  bool showDropdown = false;

  void toggleDropdown() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double screenHeight =
              constraints.maxHeight; // Get the height of the safe area
          double screenWidth =
              constraints.maxWidth; // Get the width of the safe area
          return Scaffold(
            resizeToAvoidBottomInset:
                false, //Keyboard doesn't resize the screen
            body: SizedBox(
              //SizedBox to set the height and width of the Page
              height: screenHeight,
              width: screenWidth,
              child: Stack(children: [
                Column(children: [
                  Container(
                    // Top Section
                    height: screenHeight * 0.1,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                                    onTap: () {
                                      // Add your navigation logic here
                                      // For example, you can use Navigator to navigate to another screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsScreen()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 1),
                        Container(
                          child: Image(
                            image:
                                AssetImage('assets/icons/Account circle.png'),
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      // Middle section
                      height: screenHeight * 0.9,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          //All your content for the page goes in here (Green zone)

                          Container(
                              margin: EdgeInsets.only(bottom: 80),
                              width: 350,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 192, 192, 192),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius here
                            ),
                            padding: EdgeInsets.all(9.0),
                            width: 350,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              // Set the padding for the text here
                              child: Text(
                                'We take your privacy very seriously and are committed to protecting your personal information. This privacy policy explains how we collect, use, and share information about you when you use our digital wallet app, "The Wallet".',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 192, 192, 192),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(9.0),
                            width: 350,
                            child: Column(
                              // Wrap the content in a Column widget
                               // Align the content to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          5.0), // Add spacing below the topic
                                  child: Text(
                                    // Add the topic text here
                                    'Information We Collect', 
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Personal Information: When you create an account and use our App, we may collect personal information such as your name, email address, phone number, and billing address. We do not collect or store your card numbers or security codes; instead, we securely tokenize and encrypt this information.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 192, 192, 192),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(9.0),
                            width: 350,
                            child: Column(
                              // Wrap the content in a Column widget
                               // Align the content to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          5.0), // Add spacing below the topic
                                  child: Text(
                                    // Add the topic text here
                                    'Data Security', 
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'We take reasonable measures to protect your personal information and card details from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the Internet or electronic storage is completely secure. Therefore, while we strive to protect your information, we cannot guarantee its absolute security.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 192, 192, 192),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(9.0),
                            width: 350,
                            child: Column(
                              // Wrap the content in a Column widget
                               // Align the content to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          5.0), // Add spacing below the topic
                                  child: Text(
                                    // Add the topic text here
                                    'Data Retention', 
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "We retain your personal information and card details only for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 192, 192, 192),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(9.0),
                            width: 350,
                            child: Column(
                              // Wrap the content in a Column widget
                               // Align the content to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          5.0), // Add spacing below the topic
                                  child: Text(
                                    // Add the topic text here
                                    'Changes to this Privacy Policy', 
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "We may update this Privacy Policy from time to time. Any changes will be effective immediately upon posting the revised policy in the App",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 110),
                        ]),
                      )),
                ]),
                Positioned(
                  //Navbar
                  bottom: 0,
                  child: Navbar(currentPage: 'settings'),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }
}
