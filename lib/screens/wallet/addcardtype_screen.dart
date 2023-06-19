// ignore: file_names
import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/screens/forms/forms__NIC.dart';
import 'package:the_wallet/screens/forms/forms_studentID.dart';
import 'package:the_wallet/screens/forms/forms_membershipID.dart';
import 'package:the_wallet/screens/forms/forms_drivingID.dart';

class AddCardTypeScreen extends StatefulWidget {
  static const TextStyle addBtnTextSyle = TextStyle(color: secondaryColor);

  static ButtonStyle get addBtnStyle => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0))));
  @override
  _AddCardTypeScreenState createState() => _AddCardTypeScreenState();
}

class _AddCardTypeScreenState extends State<AddCardTypeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                    Container(
                      child: Text(
                        "Select Card Type",
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.only(top: screenHeight * 0.13),
                      child: ElevatedButton(
                          onPressed: () {
                            // add function
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentIDFormScreen()),
                            );
                          },
                          style: AddCardTypeScreen.addBtnStyle,
                          child: Text(
                            "Student ID Card",
                            style: AddCardTypeScreen.addBtnTextSyle,
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
                                  builder: (context) => NICFormScreen()),
                            );
                          },
                          style: AddCardTypeScreen.addBtnStyle,
                          child: Text(
                            "National ID Card",
                            style: AddCardTypeScreen.addBtnTextSyle,
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
                                  builder: (context) => MembershipIDFormScreen()),
                            );
                          },
                          style: AddCardTypeScreen.addBtnStyle,
                          child: Text(
                            "Membership Card",
                            style: AddCardTypeScreen.addBtnTextSyle,
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
                                  builder: (context) => DrivingIDFormScreen()),
                            );
                          },
                          style: AddCardTypeScreen.addBtnStyle,
                          child: Text(
                            "Driving License Card",
                            style: AddCardTypeScreen.addBtnTextSyle,
                          )),
                    ),
                  ],
                )),
            Positioned(
              bottom: 0.0,
              child: Container(
                child: Navbar(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
