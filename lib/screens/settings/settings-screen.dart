// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/screens/settings/manage-wallet.dart';
import 'package:the_wallet/screens/settings/privacyPolicy.dart';

import 'FAQ.dart';
import 'T&C.dart';
import 'contactUs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    super.dispose();
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
                      child: Column(
                        children: [
                          //All your content for the page goes in here (Green zone)

                          Container(
                            margin: EdgeInsets.only(bottom: 80),
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManageWalletScreen()));
                                    // Add your button click logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/MW.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Manage Wallet',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/logbook.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Log Book',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      20), // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Notification.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Notification settings',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                      60), // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => FAQScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/FAQ.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'FAQ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                      20), // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            ContactUsScreen())); // Add your button click logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Contact us.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Contact us',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                      20), // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermAndCondScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/T & C.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Terms & Conditions',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                      20), // Add spacing between the buttons
                              Container(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button click logic here
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                privacyPolicyScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    backgroundColor:
                                        Color.fromARGB(255, 192, 192, 192),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Privacy Policy.png',
                                              width: 20,
                                              height: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Privacy Policy',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
