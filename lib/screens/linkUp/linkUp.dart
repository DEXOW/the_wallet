// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:the_wallet/qr.dart';
import 'package:the_wallet/screens/scanQr/scanQr.dart';

class LinkUpWidget extends StatefulWidget {
  LinkUpWidget({Key? key}) : super(key: key);

  @override
  State<LinkUpWidget> createState() => _linkupwidgetstate();
}

class _linkupwidgetstate extends State<LinkUpWidget> {
  var jsonData = {
    'id': 1,
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 10),
        Positioned(
          left: 110,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QRCodeWidget(json.encode(jsonData).toString()),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanQrCodeWidget()));
                      },
                      child: Text('Scan QR')),
                  SizedBox(height: 60),
                  SizedBox(
                    width: 250,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Positioned(
                          child: SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Center(
                                        child: Image.asset('assets/icons/qrCode.png',
                                            width: 30, height: 30),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'QR',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Center(
                                        child: Image.asset('assets/icons/contactless.png',
                                            width: 30, height: 30),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'NFC',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
