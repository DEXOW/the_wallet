import 'package:flutter/material.dart';
import 'package:the_wallet/screens/settings/settings-screen.dart';
import '../components/navbar.dart';
import 'manage-wallet.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingsScreen(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 1),
                                Expanded(
                                  child: Text(
                                    "FAQ",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Text(
                              "We're happy to help.",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Inter',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: 50),
                          CollapsiblePanel(
                            title: 'How to set up a digital wallet account?',
                            content:
                                'To set up a digital wallet account, create an account using your personal information, and link your preferred payment methods, such as a credit card or bank account.',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'Is it safe to use a digital wallet app to make payments?',
                            content:
                                "Yes, digital wallet apps use encryption and other security measures to protect your payment information and prevent unauthorized access. However, it's important to use strong passwords, keep your device and app up to date, and be cautious when using public Wi-Fi networks.",
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'What fees are associated with using a digital wallet app?',
                            content:
                                'Fees associated with using a digital wallet app can vary depending on the provider and the type of transaction. Some providers may charge fees for adding or withdrawing funds, while others may charge transaction fees for purchases.',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'What happens if my phone is lost or stolen?',
                            content:
                                'If your phone is lost or stolen, you should immediately contact your digital wallet provider to report the issue and disable your account. Many providers offer additional security features like remote wipe and device tracking to help protect your information.',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'How do I update my personal information in the digital wallet app?',
                            content:
                                'You can typically update your personal information in the digital wallet app settings, which may include information like your name, address, and contact information.',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'What happens if a transaction fails or is declined?',
                            content:
                                'If a transaction fails or is declined, you should contact your digital wallet provider to determine the cause of the issue and resolve any potential issues with your account or payment method.',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'What types of payment methods can I link to my digital wallet account?',
                            content:
                                'Most digital wallet apps allow you to link a variety of payment methods, including credit cards, debit cards, and bank accounts. ',
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'Can I use my digital wallet app to pay bills?',
                            content:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'How do I view my transaction history in the digital wallet app?',
                            content:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'How do I add and remove cards from the digital wallet app?',
                            content:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
                          ),
                          SizedBox(height: 10),
                          CollapsiblePanel(
                            title:
                                'What happens if my phone is lost or stolen?',
                            content:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
                          ),
                          // SizedBox(height: 10),
                          // CollapsiblePanel(
                          //   title: 'What happens if my phone is lost or stolen?',
                          //   content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
                          // ),
                          SizedBox(height: 105),
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

class CollapsiblePanel extends StatefulWidget {
  final String title;
  final String content;

  const CollapsiblePanel({
    required this.title,
    required this.content,
  });

  @override
  _CollapsiblePanelState createState() => _CollapsiblePanelState();
}

class _CollapsiblePanelState extends State<CollapsiblePanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
     // borderRadius: BorderRadius.circular(8.0),
     
      child: Column(
        children: [
          // ListTile(
          //   tileColor: Color.fromARGB(255, 192, 192, 192),
          //   title: Text(
          //     widget.title,
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontFamily: 'Inter',
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //     ),
          //   ),
          //   onTap: () {
          //     setState(() {
          //       _isExpanded = !_isExpanded; //This means that if _isExpanded is true, it will become false, and vice versa.
          //     });
          //   },
          // ),

          ListTile(
            title: ClipRRect(
              borderRadius: BorderRadius.circular(5), // Set the border radius
              child: Container(
                color: Color.fromARGB(255, 192, 192, 192), // Set the background color
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                width: 10,
              ),
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),

          // if (_isExpanded)
          //   Container(
          //     color: Color.fromARGB(141, 192, 192, 192),
          //     padding: EdgeInsets.all(10.0),
          //     //width: 270,
          //     child: Text(
          //       widget.content,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 14, // Set the text color for the content
          //       ),
          //     ),
          //   ),

          if (_isExpanded)
            ClipRRect(
              borderRadius: BorderRadius.circular(5), // Set the border radius
              child: Container(
                color: Color.fromARGB(141, 192, 192, 192),
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.content,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
