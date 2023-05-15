// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/contactlessPay/contactlessPay.dart';
import 'package:the_wallet/screens/linkUp/linkUp.dart';
import 'package:the_wallet/screens/components/dropdown-menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentPage = "Home";

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
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFFFFFFFF),
                                ),
                                onPressed: () {},
                                iconSize: 25.0,
                                color: bgColor,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xCCFFFFFF),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.person_rounded,
                                    color: linkUpMain,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: const Duration(milliseconds: 300),
                                        pageBuilder:
                                            (context, animation, secondaryAnimation) =>
                                                Placeholder(),
                                        transitionsBuilder:
                                            (context, animation, secondaryAnimation, child) {
                                          const begin = Offset(0.0, -1.0);
                                          const end = Offset.zero;
                                          final tween = Tween(begin: begin, end: end);
                                          final curvedAnimation = CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeInOut,
                                          );
                                          return SlideTransition(
                                            position: tween.animate(curvedAnimation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  iconSize: 20.0,
                                  color: bgColor,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                              ),
                              // DropDown(),
                            ],
                          ),
                        ),
                        Container( // Middle section
                          height: screenHeight * 0.9,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints){
                              if (currentPage == "contactless"){ 
                                return ContactlessPaymentWidget();
                              }
                              else if (currentPage == "linkup"){
                                return LinkUpWidget();
                              }
                              else {
                                return Text("Nothing to show");
                              }
                          })
                        //All your content for the page goes in here (Green zone)
                        )
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
                                    onPressed: () {
                                      setState(() {
                                        currentPage = "contactless";
                                      });
                                    }, 
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
                                    onPressed: () {
                                      setState(() {
                                        currentPage = "linkup";
                                      });
                                    }, 
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
