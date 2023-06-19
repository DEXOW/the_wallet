import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/screens/contactless_pay/choose_card_for_contactless_screen.dart';
import 'package:the_wallet/screens/components/tempcards.dart';

class ContactlessPayScreen extends StatefulWidget {
  ContactlessPayScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactlessPayScreen> createState() => _ContactlessPayScreenState();
}

class _ContactlessPayScreenState extends State<ContactlessPayScreen> {
// late UserDataProvider userDataProvider;
  ValueNotifier<dynamic> result = ValueNotifier(null);

  late UserDataProvider userDataProvider;

  Widget defaultCard() {
    return Container(
      width: 500,
      height: 200,
      margin: const EdgeInsets.only(bottom: 16, top: 40),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(134, 129, 129, 61),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.add_circle_outline,
        size: 70,
        color: Color(0xFF2C2B2B),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;

      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);

    int? activeCard = userDataProvider.userData.activeCard;

    return Column(
      children: [
        const SizedBox(height: 30),
        InkWell(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseCardForContactlessWidget(),
            ),
          );
        }, child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          userDataProvider.addListener(() {
            setState(() {});
          });
          if (activeCard == 0) {
            return defaultCard();
          } else if (activeCard != null && activeCard > 0) {
            return buildCards(
              identifier: userDataProvider.userData.activeCard,
            );
          } else {
            return defaultCard();
          }
        })),
        Container(
          margin: EdgeInsets.only(top: 150),
          child: IconButton(
            icon: const Icon(Icons.contactless),
            iconSize: 100,
            onPressed: () {
              _tagRead();
            },
          ),
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
