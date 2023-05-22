import 'package:flutter/material.dart';
import 'package:the_wallet/screens/chooseCardForContactless/chooseCardForContactless.dart';

class ContactlessPaymentWidget extends StatefulWidget {
  ContactlessPaymentWidget({Key? key}) : super(key: key);

  @override
  State<ContactlessPaymentWidget> createState() =>
      _contactlesspaymentwidgetstate();
}

class _contactlesspaymentwidgetstate extends State<ContactlessPaymentWidget> {
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
              child: const Icon(
                Icons.add_circle_outline,
                size:
                    70, // Change the size to your desired value, for example, 32
                color: Color(
                    0xFF2C2B2B), // Change the color to ARGB(255, 44, 43, 43)
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: 150),
          child: Image.asset(
            'assets/icons/contactless.png',
            scale: 1.1,
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
