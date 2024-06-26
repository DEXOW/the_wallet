// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/social_card.dart';
// import 'package:the_wallet/screens/root/root_screen.dart';

class ScanQrCodeWidget extends StatefulWidget {
  const ScanQrCodeWidget({Key? key}) : super(key: key);

  @override
  State<ScanQrCodeWidget> createState() => ScanQrCodeWidgetState();
}

class SocialCardData {
  String fname;
  String lname;
  String career;
  String age;
  String email;
  String phoneNo;
  String linkedIn;
  String twitter;
  String instagram;
  String facebook;
  String pictureUrl;

  SocialCardData({
    required this.fname,
    required this.lname,
    required this.career,
    required this.age,
    required this.email,
    required this.phoneNo,
    required this.linkedIn,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.pictureUrl,
  });
}

class ScanQrCodeWidgetState extends State<ScanQrCodeWidget> {
  // Create an instance of QRViewController
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  late String? scannedData = '';
  late String? finalCardID;

  SocialCardData socialcardData = SocialCardData(
      fname: '',
      lname: '',
      career: '',
      age: '',
      email: '',
      phoneNo: '',
      linkedIn: '',
      twitter: '',
      instagram: '',
      facebook: '',
      pictureUrl: '');

  // Function to handle QR scan results
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    String? cardID;
    Map<String, dynamic> cardIDMAP;
    controller.scannedDataStream.listen((scanData) async {
      // Handle the scanned QR code data here
      setState(() {
        cardID = scanData.code;
        cardIDMAP = json.decode(cardID!);
        finalCardID = cardIDMAP['cardID'];
      });

      // Pause the scanner after successful scan
      controller.pauseCamera();

      // await addCard(finalCardID!);

      await searchCardFirestore(finalCardID!);

      openSocialCard();

      // await searchCardFirestore(finalCardID!);
      // controller.dispose();
    });
  }

  Future<void> addCard(String cardID) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      List<dynamic> cardIDs =
          value.data()!['savedSocialCards'] as List<dynamic>;
      cardIDs.add(cardID);
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({
        'savedSocialCards': cardIDs,
      });
    });
  }

  void openSocialCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 420,
            color: Colors.transparent,
            child: Column(
              children: [
                ViewSocialCard(
                  firstname: socialcardData.fname,
                  lastname: socialcardData.lname,
                  career: socialcardData.career,
                  age: socialcardData.age,
                  phoneNo: socialcardData.phoneNo,
                  email: socialcardData.email,
                  linkedIn: socialcardData.linkedIn,
                  twitter: socialcardData.twitter,
                  instagram: socialcardData.instagram,
                  facebook: socialcardData.facebook,
                  pictureUrl: socialcardData.pictureUrl,
                ),
                TextButton(
                  onPressed: () {
                    addCard(finalCardID!);

                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Card Successfully Added',
                          style: TextStyle(
                              color: Color.fromARGB(255, 174, 167, 167)),
                        ),
                        backgroundColor: primaryBgColor,
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primaryBgColor),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Save Social Card'),
                        Icon(Icons.get_app),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> searchCardFirestore(String cardID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final cardList = await firestore.collectionGroup('cards').get();

    if (cardList.docs.any((element) => element.id == cardID)) {
      Map<String, dynamic> cardData;
      // cardData = cardList.docs.firstWhere((element) => element['cardID'] == cardID).data();

      cardData =
          cardList.docs.where((element) => element.id == cardID).first.data();

      socialcardData.fname = cardData['fname'];
      socialcardData.lname = cardData['lname'];
      socialcardData.career = cardData['career'];
      socialcardData.age = cardData['age'];
      socialcardData.email = cardData['email'];
      socialcardData.phoneNo = cardData['phoneNo'];
      socialcardData.linkedIn = cardData['linkedin'];
      socialcardData.twitter = cardData['twitter'];
      socialcardData.instagram = cardData['instagram'];
      socialcardData.facebook = cardData['facebook'];
      socialcardData.pictureUrl = cardData['pictureUrl'];
      // }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth =
                constraints.maxWidth; // Get the width of the safe area
            double qrSize =
                screenWidth * 0.7; // Adjust the size of the QR code widget
            return Stack(children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: qrSize,
                        width: qrSize,
                        margin: EdgeInsets.only(bottom: 150),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Customize the border color
                            width: 2.0, // Customize the border width
                          ),
                        ),
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
