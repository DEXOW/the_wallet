import 'package:flutter/material.dart';
import 'package:the_wallet/screens/chooseCardForContactless/chooseCardForContactless.dart';

class ContactlessPaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseCardForContactlessWidget(),
              ),
            );
          },
          child: Container(
            width: 500,
            height: 200,
            margin: EdgeInsets.only(bottom: 16, top: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(134, 129, 129, 61),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.only(top: 70, bottom: 70),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Color.fromARGB(255, 44, 43, 43), width: 6),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 140,
                    top: 20,
                    bottom: 20,
                    right: 140,
                    child: Container(
                      width: 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 44, 43, 43),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 156,
                    top: 5,
                    bottom: 5,
                    right: 156,
                    child: Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 44, 43, 43),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 150),
          child: Image.asset(
            'assets/icons/contactless.png',
            scale: 1,
            // width: 500,
            // height: 500,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Tap to Pay',
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(255, 255, 255, 55),
          ),
        ),
      ],
    );
  }
}
