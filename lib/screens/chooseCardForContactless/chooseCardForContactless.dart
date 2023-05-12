import 'package:flutter/material.dart';

class ChooseCardForContactlessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            return Scaffold(
              resizeToAvoidBottomInset:
                  false, //Keyboard doesn't resize the screen
              body: Column(
                children: const [
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
                      color: Color.fromRGBO(255, 255, 255, 0.593)
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
