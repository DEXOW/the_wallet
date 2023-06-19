// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/screens/wallet/addcardoption_screen.dart';
import 'package:the_wallet/data_classes/studentID_data.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> cardStream;
  List<DocumentSnapshot<Map<String, dynamic>>> cardList = [];
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Fetch card data from Firestore and store it in cardStream
    cardStream = _firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cards')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: primaryBgColor,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: screenHeight * 0.005,
                left: screenWidth * 0.01,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/acount circle.png'),
                      height: 70,
                      width: 70,
                    ),
                    SizedBox(
                      width: screenWidth * 0.65,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to another screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCardOptionsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        child: Image.asset(
                          'assets/icons/Add.png',
                          width: 35,
                          height: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.05,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "My Wallet",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/icons/one.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Container(
                            child: Image.asset(
                              'assets/icons/three.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Container(
                            child: Image.asset(
                              'assets/icons/wallet.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Container(
                            child: Image.asset(
                              'assets/icons/wallet.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    SingleChildScrollView(
                      child: Container(
                        height: screenHeight * 0.75,
                        width: screenWidth * 0.9,
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: cardStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator while fetching data
                            } else if (snapshot.hasData) {
                              cardList = snapshot.data!
                                  .docs; // Store the retrieved documents in cardList
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: cardList.length,
                                itemBuilder: (context, index) {
                                  final cardData = cardList[index]
                                      .data(); // Get the card data at the current index

                                  // Determine the card type
                                  final cardType = cardData?['cardType'];
                                  // Create a widget based on the card type
                                  Widget cardWidget;
                                  switch (cardType) {
                                    case 'National ID':
                                      cardWidget =
                                          buildNationalIDCard(cardData);
                                      break;
                                    case 'Student ID':
                                      cardWidget = buildStudentIDCard(cardData);
                                      break;
                                    case 'Membership ID':
                                      cardWidget =
                                          buildMembershipIDCard(cardData);
                                      break;
                                    case 'Driving ID':
                                      cardWidget = buildDrivingIDCard(cardData);
                                      break;
                                    default:
                                      cardWidget =
                                          Container(); // Empty container if unknown card type
                                  }

                                  return cardWidget;
                                },
                              );
                            } else {
                              return Text(
                                  'No data found.'); // Display a message if no data is available
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  child: Navbar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget boldText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget buildNationalIDCard(Map<String, dynamic>? cardData) {
    return Container(
      margin: EdgeInsets.only(bottom: 40), // Set the bottom margin of 40
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 225,
          width: MediaQuery.of(context).size.width * 0.9,
          color: Color.fromARGB(255, 57, 114, 221),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Column(
                children: [
                  const Text(
                    'National Identity Card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    cardData?['fullName'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Text('National ID Card'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          cardData?[
                              'imageUrl'], // Replace 'cardData' with the appropriate variable containing the image URL
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          child: Table(
                            columnWidths: const {
                              0: FixedColumnWidth(70),
                              1: FixedColumnWidth(10),
                              2: FixedColumnWidth(100),
                            },
                            children: [
                              TableRow(
                                children: [
                                  boldText('National ID Number'),
                                  boldText(':'),
                                  Text(cardData?['nicNumber']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Date of Issue'),
                                  boldText(':'),
                                  Text(cardData?['dateOfIssue']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Sex'),
                                  boldText(':'),
                                  Text(cardData?['sex']),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cardData?['serialNumber']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStudentIDCard(Map<String, dynamic>? cardData) {
    return Container(
        margin: EdgeInsets.only(bottom: 40), // Set the bottom margin of 40
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 225,
            color: Color.fromARGB(255, 84, 193, 126),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Column(
                  children: [
                    const Text(
                      'Student Identity Card',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      cardData?['studentName'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // Text('Student Identity Card'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            cardData?[
                                'imageUrl'], // Replace 'cardData' with the appropriate variable containing the image URL
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(70),
                                1: FixedColumnWidth(10),
                                2: FixedColumnWidth(100),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    boldText('Student ID'),
                                    boldText(':'),
                                    Text(cardData?['studentIDNumber']),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    boldText('Expiry Date'),
                                    boldText(':'),
                                    Text(cardData?['expiryDate']),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    boldText('Batch Code'),
                                    boldText(':'),
                                    Text(cardData?['batchCode']),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cardData?['orgName']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildMembershipIDCard(Map<String, dynamic>? cardData) {
    return Container(
        margin: EdgeInsets.only(bottom: 40), // Set the bottom margin of 40
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 225,
            color: Color.fromARGB(255, 174, 95, 235),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Column(
                  children: [
                    const Text(
                      'Membership ID card',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      cardData?['firstName'] + ' ' + cardData?['lastName'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // Text('Student Identity Card'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            cardData?[
                                'imageUrl'], // Replace 'cardData' with the appropriate variable containing the image URL
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(10),
                                2: FixedColumnWidth(100),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    boldText('Membership ID'),
                                    boldText(':'),
                                    Text(cardData?['membershipIDNumber']),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    boldText('Expiry Date'),
                                    boldText(':'),
                                    Text(cardData?['expiryDate']),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    boldText('Phone Number'),
                                    boldText(':'),
                                    Text(cardData?['phoneNumber']),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cardData?['orgName']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildDrivingIDCard(Map<String, dynamic>? cardData) {
    return Container(
      margin: EdgeInsets.only(bottom: 40), // Set the bottom margin of 40
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 225,
          width: MediaQuery.of(context).size.width * 0.9,
          color: Color.fromARGB(255, 235, 70, 111),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Column(
                children: [
                  const Text(
                    'Driving License Card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    cardData?['surname'] + ' ' + cardData?['otherNames'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Text('National ID Card'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          cardData?[
                              'imageUrl'], // Replace 'cardData' with the appropriate variable containing the image URL
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          child: Table(
                            columnWidths: const {
                              0: FixedColumnWidth(90),
                              1: FixedColumnWidth(10),
                              2: FixedColumnWidth(100),
                            },
                            children: [
                              TableRow(
                                children: [
                                  boldText('Driving License No'),
                                  boldText(':'),
                                  Text(cardData?['drivingID']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Date of Birth'),
                                  boldText(':'),
                                  Text(cardData?['dateOfBirth']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Date of Issue'),
                                  boldText(':'),
                                  Text(cardData?['dateOfIssue']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Date of Expiry'),
                                  boldText(':'),
                                  Text(cardData?['dateOfExpiry']),
                                ],
                              ),
                              TableRow(
                                children: [
                                  boldText('Address'),
                                  boldText(':'),
                                  Text(cardData?['address']),
                                ],
                              ),
                              
                            ],
                          ))
                    ],
                  ),
                ],
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cardData?['serialNumber']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
