import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/wallet/addcardtype_screen.dart';

class AddCardOptionsScreen extends StatefulWidget {
  static const TextStyle addBtnTextSyle = TextStyle(color: secondaryColor);

  static ButtonStyle get addBtnStyle => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0))));
  @override
  _AddCardOptionScreenState createState() => _AddCardOptionScreenState();
}

class _AddCardOptionScreenState extends State<AddCardOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
        backgroundColor: primaryBgColor,
        body: SafeArea(
            child: Scaffold(
                backgroundColor: primaryBgColor,
                body: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Positioned(
                      top: screenHeight * 0.005,
                      left: 0,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: secondaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 35,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/icons/icon.png'),
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: screenHeight * 0.05,
                        child: Column(
                          children: [
                            // Container(
                            //   child:
                            // ),
                            Container(
                              child: Text(
                                "Add a Card",
                                style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              margin: EdgeInsets.only(top: screenHeight * 0.23),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // add function
                                  },
                                  style: AddCardOptionsScreen.addBtnStyle,
                                  child: Text(
                                    "Scan To Add",
                                    style: TextStyle(color: secondaryColor),
                                  )),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              margin: EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // add function
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddCardTypeScreen()),
                                    );
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0)))),
                                  child: Text(
                                    "Manual",
                                    style: TextStyle(color: secondaryColor),
                                  )),
                            )
                          ],
                        )),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        child: Navbar(),
                      ),
                    )
                  ],
                ))));
  }
}
