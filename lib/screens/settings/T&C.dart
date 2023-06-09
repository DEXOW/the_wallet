// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:the_wallet/screens/settings/settings-screen.dart';

import '../components/navbar.dart';
import 'manage-wallet.dart';

class TermAndCondScreen extends StatefulWidget {
  const TermAndCondScreen({super.key});

  @override
  State<TermAndCondScreen> createState() => _TermAndCondScreenState();
}

class _TermAndCondScreenState extends State<TermAndCondScreen> {
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Terms & Conditions",
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
                                'Welcome to "The Wallet", a digital wallet app that allows you to store your national ID card, university ID card, credit card, and debit card information in one place for easy access and payment. These terms and conditions ("Terms") govern your use of "The Wallet". By using "The Wallet", you agree to these Terms. If you do not agree to these Terms, do not use "The Wallet".',
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
                                    'Use of Wallet', 
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
                                    '"The Wallet" is provided to you for personal use only. You agree to use "The Wallet" in compliance with all applicable laws and regulations. You are responsible for maintaining the confidentiality of your login information and for all activities that occur under your account.',
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
                                    'Privacy', 
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
                                    'We take your privacy very seriously. Please refer to our privacy policy for information about how we collect, use, and share information about you when you use "The Wallet".',
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
                                    'Termination', 
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
                                    "The App provider reserves the right to suspend or terminate a user's account or access to the App at any time and for any reason. Users may terminate their account by following the instructions provided in the App",
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
                                    'User Responsibilities', 
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
                                    "Users agree to use the App in accordance with applicable laws, regulations, and these terms and conditions. Users agree not to use the App for any unlawful, fraudulent, or unauthorized purposes.",
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
