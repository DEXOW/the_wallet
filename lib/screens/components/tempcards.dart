import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/screens/contactlessPay/contactlessPay.dart';
import 'package:the_wallet/screens/components/user-data.dart';

class buildCards extends StatefulWidget {
  int? identifier;
  buildCards({Key? key, required this.identifier}) : super(key: key);

  @override
  State<buildCards> createState() =>
      _buildCardsState();
}

class _buildCardsState extends State<buildCards>{
   late UserDataProvider userDataProvider;

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);
    return Material(
      child: GestureDetector(
        onTap: () {
          print('This is the widget identifier ${widget.identifier}');
          userDataProvider.userData.activeCard = widget.identifier;
          Navigator.pop(context);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ContactlessPaymentWidget(activeCard: widget.identifier)));
        },
        child: Container(
          key: ValueKey(widget.identifier),
          width: 350,
          height: 200,
          margin: EdgeInsets.only(bottom: 16, top: 16),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 0, 0, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(
            'Card ${widget.identifier}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }
}