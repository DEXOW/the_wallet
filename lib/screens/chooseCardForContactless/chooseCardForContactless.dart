// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:the_wallet/screens/components/tempcards.dart';
import '../components/navbar.dart';
import 'package:the_wallet/screens/chooseCardForContactless/chooseCardForContactless.dart';

class ChooseCardForContactlessWidget extends StatefulWidget {
  ChooseCardForContactlessWidget({Key? key}) : super(key: key);

  @override
  State<ChooseCardForContactlessWidget> createState() =>
      _choosecardforcontactlesswidget();
}

class _choosecardforcontactlesswidget
    extends State<ChooseCardForContactlessWidget> {
  int num = 3;

  // static Widget _cards(int identifier, Function(int) onPressed) {
  //   return GestureDetector(
  //     onTap: () {
  //       onPressed(identifier);
  //     },
  //     child: Container(
  //       key: ValueKey(identifier),
  //       width: 350,
  //       height: 200,
  //       margin: EdgeInsets.only(bottom: 16, top: 16),
  //       decoration: BoxDecoration(
  //         color: Color.fromRGBO(255, 0, 0, 1),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Center(child: Text(
  //         'Card $identifier',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 24,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       )),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    int num = 3;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 330),
              child: Center(
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double screenHeight =
                constraints.maxHeight; // Get the height of the safe area
            double screenWidth =
                constraints.maxWidth; // Get the width of the safe area
            return Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset:
                      false, //Keyboard doesn't resize the screen
                  body: Column(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Choose One',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Payment Cards',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 0.593)),
                      ),
                      // _cards(),
                      Container(
                        height: screenHeight * 0.75,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: LayoutBuilder(builder:
                              (BuildContext context, BoxConstraints constraints) {
                            return Column(
                              children: [for (int i = 1; i <= num; i++) buildCards(identifier:i)],
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  //Navbar
                  bottom: 0,
                  child: Navbar(currentPage: 'contactless'),
                ),
              ],
            );
          }),
        ));
  }
}
