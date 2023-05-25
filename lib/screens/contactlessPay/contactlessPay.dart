// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/screens/chooseCardForContactless/chooseCardForContactless.dart';
import 'package:the_wallet/screens/chooseCardForContactless/chooseCardForContactless.dart';
import 'package:the_wallet/screens/components/tempcards.dart';
import 'package:the_wallet/screens/components/user-data.dart';

class ContactlessPaymentWidget extends StatefulWidget {
  int? activeCard;
  ContactlessPaymentWidget({Key? key, this.activeCard}) : super(key: key);

  @override
  State<ContactlessPaymentWidget> createState() =>
      _contactlesspaymentwidgetstate();
}

class _contactlesspaymentwidgetstate extends State<ContactlessPaymentWidget> {
  
  late UserDataProvider userDataProvider;

  Widget defaultCard() {
    return Container(
      width: 500,
      height: 200,
      margin: EdgeInsets.only(bottom: 16, top: 40),
      decoration: BoxDecoration(
        color: Color.fromRGBO(134, 129, 129, 61),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.add_circle_outline,
        size: 70, // Change the size to your desired value, for example, 32
        color: Color(0xFF2C2B2B), // Change the color to ARGB(255, 44, 43, 43)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);
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
            child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints constraints) {
                      userDataProvider.addListener(() {
                        setState(() {
                          
                        });
                      });
                      if(userDataProvider.userData.activeCard == null)
                      {
                        print('The active card is 1 ${userDataProvider.userData.activeCard}');
                        return defaultCard();
                      }
                      else{
                        print('The active card is 2 ${userDataProvider.userData.activeCard}');
                        return buildCards(identifier: userDataProvider.userData.activeCard,);
                      }
                    })),
        Container(
          margin: EdgeInsets.only(top: 150),
          child: const Icon(Icons.contactless, size: 100),
        ),
        const SizedBox(height: 3),
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
