// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/screens/settings/send-feedback.dart';
import 'package:the_wallet/screens/settings/settings-screen.dart';

// class ContactUsScreen extends StatefulWidget {
//   const ContactUsScreen({super.key});

//   @override
//   State<ContactUsScreen> createState() => _ContactUsScreenState();
// }
class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();

  void _submitForm() {
    // Perform any necessary actions with the entered data
    // Reset the text fields
    textFieldController1.clear();
    textFieldController2.clear();
    textFieldController3.clear();
  }

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
                                      "Contact Us",
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

                          Image.asset(
                            'assets/icons/Caller.png', // Replace with your image path
                            width: 500,
                            height: 200,
                          ),

                          SizedBox(height: 16.0),
                          Text(
                            "Call us or send a message and we'll respond as soon as possibile.",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name *',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              TextField(
                                controller: textFieldController1,
                                maxLines: null,
                                decoration: InputDecoration(
                                 //hintText: 'Enter text',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email *',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              TextField(
                                controller: textFieldController2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  //hintText: 'Enter text',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Message',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              TextField(
                                controller: textFieldController3,
                                maxLines: null,
                                decoration: InputDecoration(
                                  //hintText: 'Enter text',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40.0),
                          Container(
                            width: 200,
                            height: 40, // Set the desired width
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 150),
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
