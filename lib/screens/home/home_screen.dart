import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/components/card_templates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserDataProvider userDataProvider;
  late DateTime now;
  String greeting = '';

  @override
  Widget build(BuildContext context){
    userDataProvider = Provider.of<UserDataProvider>(context);
    now = DateTime.now();
    if(now.hour < 12){
      greeting = 'Good Morning';
    } else if(now.hour < 18){
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40, bottom: 80),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.5
                  ),
                )
              ),
              Text(
                '${userDataProvider.userData.fname} ${userDataProvider.userData.lname}',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 0.55),
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 460,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constratins) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).get(),
                  builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cardList = snapshot.data!['recentCards'];
                    return Column(
                      children: List.generate(cardList.length, (index) => FutureBuilder(
                        future: FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).collection('cards').doc(cardList[index]).get(), 
                        builder: (context, snapshot) {
                          if(snapshot.hasData && snapshot.data != null){
                            final cardData = snapshot.data!.data() as Map<String, dynamic>;
                            switch (cardData['cardType']){
                              case 'SIC':
                                return stdCardTemplate(cardData: cardData);
                              case 'NIC':
                                return idCardTemplate(cardData: cardData);
                              default:
                                return Container();
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }
                      )),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
              },
            )
          ),
        )
      ]
    );
  }

  Widget cardTemplate(String cardName){
    return Container(
      height: 180,
      width: 300,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          cardName,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      )
    );
  }
}