// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:the_wallet/qr.dart';
import 'package:the_wallet/screens/scanQr/scanQr.dart';
import 'package:the_wallet/screens/components/showSocialCard.dart';

class LinkUpWidget extends StatefulWidget {
  LinkUpWidget({Key? key}) : super(key: key);

  @override
  State<LinkUpWidget> createState() => _linkupwidgetstate();
}

class _linkupwidgetstate extends State<LinkUpWidget> {
  // var jsonData = {
  //   'id': 1,
  // };

  // late Map<String,dynamic> SocialCardData;

  // String firstname = '';

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   await fetchData();
  // }

  // Future<void> updateSocialCardData() async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('${auth.currentUser!.uid}/cards/socialcard')
  //         .snapshots()
  //         .first;

  //     SocialCardData = snapshot.data()!;
  //     print('This is data ${SocialCardData}');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> fetchData() async {
  //   await updateSocialCardData(); // Wait for data to be fetched
  // }

  // FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, dynamic> socialCardData = {
    'cardID' : ''
  };
  String firstname = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateSocialCardData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('${auth.currentUser!.uid}/cards/socialcard')
          .get();

          final data = snapshot.data();

      if (data != null) {
        socialCardData['cardID'] = data['cardID'];
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
                  QRCodeWidget(json.encode(socialCardData)),
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
                                        child: Image.asset(
                                            'assets/icons/qrCode.png',
                                            width: 30,
                                            height: 30),
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
                                        child: Image.asset(
                                            'assets/icons/contactless.png',
                                            width: 30,
                                            height: 30),
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
