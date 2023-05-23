// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';


class Navbar extends StatefulWidget {
  String currentPage;
  Navbar({Key? key, required this.currentPage}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  NavNavigator({required BuildContext context, required final destination}){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination), // Add animation
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String currentPage = widget.currentPage;
    Color selectedColor = Color(0xFF1568EF);
    Color unselectedColor = Color(0xFF000000);

    Color homeIconColor = unselectedColor;
    Color walletIconColor = unselectedColor;
    Color linkupIconColor = unselectedColor;
    Color settingsIconColor = unselectedColor;
    Color contactlessIconColor = unselectedColor;

    if (currentPage == 'home'){
      setState(() {
        homeIconColor = selectedColor;
      });
    } else if (currentPage == 'wallet'){
      setState(() {
        walletIconColor = selectedColor;
      });
    } else if (currentPage == 'linkup'){
      setState(() {
        linkupIconColor = selectedColor;
      });
    } else if (currentPage == 'settings'){
      setState(() {
        settingsIconColor = selectedColor;
      });
    } else if (currentPage == 'contactless'){
      setState(() {
        contactlessIconColor = selectedColor;
      });
    }

    late double navWidth;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (MediaQuery.of(context).size.width < 410 && MediaQuery.of(context).size.width > 150) {
          navWidth = MediaQuery.of(context).size.width - 50;
        } else if (MediaQuery.of(context).size.width < 150){
          navWidth = 150;
        } else {
          navWidth = 360;
        }
        return Container(
          width: screenWidth,
          color: primaryBgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 55,
                width: navWidth,
                // constraints: BoxConstraints(maxWidth: 360, minWidth: 150),
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
                        color: contactlessIconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: ImageIcon(
                        AssetImage('assets/icons/wallet-icon.png'),
                        size: 30,
                        color: walletIconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {NavNavigator(context: context, destination: Placeholder());}, 
                      icon: ImageIcon(
                        AssetImage('assets/icons/home-icon.png'),
                        size: 30,
                        color: homeIconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: ImageIcon(
                        AssetImage('assets/icons/linkup-icon.png'),
                        size: 30,
                        color: linkupIconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {NavNavigator(context: context, destination: Placeholder());}, 
                      icon: ImageIcon(
                        AssetImage('assets/icons/settings-icon.png'),
                        size: 30,
                        color: settingsIconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}