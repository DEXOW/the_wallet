// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';
import 'package:the_wallet/qr.dart';
import 'package:the_wallet/screens/linkup/scan_qr.dart';
import 'package:the_wallet/screens/components/social_card.dart';

class LinkUpScreen extends StatefulWidget {
  LinkUpScreen({Key? key}) : super(key: key);

  @override
  State<LinkUpScreen> createState() => _LinkUpScreenState();
}

class _LinkUpScreenState extends State<LinkUpScreen> {
  Map<String, dynamic> socialCardData = {'cardID': ''};
  String firstname = '';
  bool showqrCode = true;
  
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateSocialCardData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('${auth.currentUser!.uid}')
          .get();

      final data = snapshot.data();

      if (data != null) {
        socialCardData['cardID'] = data['socialCardId'];
      }
      print('This is data $socialCardData');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    await updateSocialCardData();
    // Wait for data to be fetched
    setState(() {
      // Rebuild the widget after data is fetched
    });
  }

  Widget qrCode() {
    return Column(
      children: [
        QRCodeWidget(json.encode(socialCardData)),
        SizedBox(height: 40),
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 18, 60, 158),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQrCodeWidget()),
              );
            },
            child: Text(
              'Scan QR',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget nfcCode() {
    return Column(
      children: [
        IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.contactless,
            ),
            iconSize: 185),
        SizedBox(height: 40),
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 18, 60, 158),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              _tagRead();
            },
            child: Text(
              'Scan NFC',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget qrIcon() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: ClipOval(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    showqrCode = true;
                  });
                },
                child: Image.asset(
                  'assets/icons/qrCode.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
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
    );
  }

  Widget nfcIcon() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: ClipOval(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    showqrCode = false;
                  });
                },
                child: Image.asset(
                  'assets/icons/contactless.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
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
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      print('This is the result ${result}');

      NfcManager.instance.stopSession();
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

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
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints contraints) {
                    if (showqrCode == true) {
                      return qrCode();
                    } else {
                      return nfcCode();
                    }
                  }),
                  SizedBox(height: 60),
                  SizedBox(
                    width: 250,
                    child: AnimatedAlign(
                      alignment: showqrCode
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      duration: Duration(
                          milliseconds: 300), // Adjust the duration as desired
                      curve: Curves
                          .easeInOut, // Adjust the animation curve as desired
                      child: Stack(
                        children: [
                          Positioned(
                            child: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  qrIcon(),
                                  nfcIcon(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
