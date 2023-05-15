// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:the_wallet/screens/components/dropdown-menu.dart';
import 'package:the_wallet/qr.dart';

class LinkUpWidget extends StatefulWidget {
  LinkUpWidget({Key? key}) : super(key: key);

  @override
  State<LinkUpWidget> createState() => _linkupwidgetstate();
}

class _linkupwidgetstate extends State<LinkUpWidget> {
  var jsonData = {
    'name': 'John Doe',
    'age': 30,
    'email': 'johndoe@example.com',
    'gmail': 'test.com'
  };

  // jsonData1 = []

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 10),
        Positioned(
          left: 120,
          child: Text(
            'Link Up',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
                child: QRCodeWidget(json.encode(jsonData).toString()),
            ),
          ],
        )
      ],
    );
  }
}
