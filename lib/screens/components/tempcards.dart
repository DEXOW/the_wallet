import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/data_classes/user_data.dart';

class buildCards extends StatefulWidget {
  final int? identifier;
  const buildCards({Key? key, required this.identifier}) : super(key: key);

  @override
  State<buildCards> createState() => BuildCardsState();
}

class BuildCardsState extends State<buildCards> {
  late UserDataProvider userDataProvider;

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          userDataProvider.userData.activeCard = widget.identifier;

          Navigator.pop(context);
        },
        child: Container(
          key: ValueKey(widget.identifier),
          width: 350,
          height: 200,
          margin: const EdgeInsets.only(bottom: 16, top: 16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 0, 0, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
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
