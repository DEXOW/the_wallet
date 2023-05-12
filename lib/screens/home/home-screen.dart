// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/contactlessPay/contactlessPay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area
            return Scaffold(
              resizeToAvoidBottomInset: false, //Keyboard doesn't resize the screen
              body: SizedBox( //SizedBox to set the height and width of the Page
                height: screenHeight,
                width: screenWidth,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container( // Top Section
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
                        Container( // Middle section
                          height: screenHeight * 0.9,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              //All your content for the page goes in here (Green zone)
                              ContactlessPaymentWidget(),
                            ],
                          )
                        ),
                      ]
                    ),
                    Positioned( //Navbar
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        color: bgColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 360,
                              margin: EdgeInsets.only(top: 15, bottom: 10, left: 25, right: 25),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/contactless-icon.png'),
                                      size: 30,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/wallet-icon.png'),
                                      size: 30,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/home-icon.png'),
                                      size: 30,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/linkup-icon.png'),
                                      size: 30,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/settings-icon.png'),
                                      size: 30,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
