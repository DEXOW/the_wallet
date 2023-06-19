import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/saved_social_card.dart';

class SavedSocialCard extends StatefulWidget {
  const SavedSocialCard({super.key});

  @override
  SavedSocialCardState createState() => SavedSocialCardState();
}

class SavedSocialCardState extends State<SavedSocialCard> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late List<SocialCardTemplate> socialCardsList;
  late List<dynamic> cardIDs;
  final ValueNotifier<bool> updateCardList = ValueNotifier(false);

  Future<void> fetchData() async {
    socialCardsList = [];
    final socialCards =
        await FirebaseFirestore.instance.collectionGroup('cards').get();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    final data = snapshot.data();
    cardIDs = data!['savedSocialCards'];
    for (var i = 0; i < cardIDs.length; i++) {
      if (cardIDs.isNotEmpty) {
        try {
          final socialCardData = socialCards.docs
              .firstWhere((element) => element.id == cardIDs[i])
              .data();
          socialCardsList.add(
            SocialCardTemplate(
              fname: socialCardData['fname'],
              lname: socialCardData['lname'],
              career: socialCardData['career'],
              age: socialCardData['age'],
              email: socialCardData['email'],
              phoneNo: socialCardData['phoneNo'],
              facebook: socialCardData['facebook'],
              instagram: socialCardData['instagram'],
              twitter: socialCardData['twitter'],
              linkedin: socialCardData['linkedin'],
              pictureUrl: socialCardData['pictureUrl'],
              cardNo: i,
              deleteCard: deleteCard,
            ),
          );
        } catch (e) {
          rethrow;
        }
      }
    }
  }

  void showSnackBar(String message, Color backgroundColor,
      {SnackBarAction? action}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
      backgroundColor: backgroundColor,
      action: action,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteCard(int cardNo) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);

    final doc = await docRef.get();
    final List<dynamic> array = doc['savedSocialCards'];

    array.removeAt(cardNo);
    await docRef.update({'savedSocialCards': array});
    socialCardsList.removeWhere((card) => card.cardNo == cardNo);
    await fetchData();
    updateCardList.value = !updateCardList.value;

    showSnackBar('Changes saved successfully!', linkUpMain);
  }

  Widget buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xCCFFFFFF),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle asynchronous loading of data
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return const Scaffold(
            backgroundColor: linkUpMain,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Data has been loaded, build your UI
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: linkUpMain,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: updateCardList,
                      builder: (context, value, child) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: socialCardsList.length,
                          separatorBuilder: (context, index) {
                            if (index == socialCardsList.length - 1) {
                              return Container(); // return empty container for last item
                            }
                            return buildDivider();
                          },
                          itemBuilder: (context, index) {
                            return socialCardsList[index];
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
