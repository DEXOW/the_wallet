// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:the_wallet/screens/components/tempcards.dart';

class ChooseCardForContactlessWidget extends StatefulWidget {
  const ChooseCardForContactlessWidget({Key? key}) : super(key: key);

  @override
  State<ChooseCardForContactlessWidget> createState() =>
      ChooseCardForContactlessWidegt();
}

class ChooseCardForContactlessWidegt
    extends State<ChooseCardForContactlessWidget> {
  int num = 5; //for number of cards

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double screenHeight =
              constraints.maxHeight; // Get the height of the safe area
          return Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset:
                    false, //Keyboard doesn't resize the screen
                body: Column(
                  children: [
                    SizedBox(height: 40),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: screenHeight * 0.75,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Column(
                            children: [
                              for (int i = 1; i <= num; i++)
                                buildCards(identifier: i)
                            ],
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
