// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/screens/components/data-classes.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/data-classes/user-data.dart';
import 'package:the_wallet/screens/login/login-screen.dart';
import 'package:the_wallet/screens/settings/settings-screen.dart';
import 'package:the_wallet/screens/startup/startup-screen.dart';

import '../../firebase/fire_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserDataProvider userDataProvider;
  late PageDataProvider pageDataProvider;
  late ValueNotifier<String> currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = ValueNotifier('home');
    print('UID =${auth.currentUser?.uid} , Email = ${auth.currentUser?.email}');
    // auth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);
    pageDataProvider = Provider.of<PageDataProvider>(context);

    if (auth.currentUser == null) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginScreen()),
      //     (route) => route.isFirst,
      //   );
      // });
      FireAuth.signInUsingEmailPassword(email: 'thinaltp@gmail.com', password: 'TTP@2k4', context: context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area
            return Scaffold(
              resizeToAvoidBottomInset: false, //Keyboard doesn't resize the screen
              body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong :('),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('No user data found. Please contact support.'),
                    );
                  }
                  Map<String, dynamic>? data = snapshot.data?.data();
                  if (data == null) {
                    return Center(
                      child: Text('No user data found. Please contact support.'),
                    );
                  }
                  userDataProvider.userData.setData(
                    fname: data['fname'],
                    lname: data['lname'],
                    email: data['email'],
                    dobDate: data['dobDate'],
                    dobMonth: data['dobMonth'],
                    dobYear: data['dobYear'],
                    phoneNo: data['phoneNo'],
                    pictureUrl: data['pictureUrl'],
                    socialCardId: data['socialCardId'],
                  );
                  // print(userDataProvider.userData.socialCardId);
                  
                  return SizedBox( //SizedBox to set the height and width of the Page
                    height: screenHeight,
                    width: screenWidth,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container( // Top Section
                              height: screenHeight * 0.1,
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(top: 10, left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image(
                                      image: AssetImage('assets/icons/icon.png'),
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container( // Middle section
                              height: screenHeight * 0.8,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: ValueListenableBuilder<String>(
                                valueListenable: currentScreen,
                                builder: (context, value, child) {
                                  pageDataProvider.addListener(() {
                                    currentScreen.value = pageDataProvider.currentScreen;
                                  });
                                  if (currentScreen.value == 'settings') {
                                    return SettingsScreen();
                                  } else { 
                                    return Center(child: Text('Home Screen'));
                                  }
                                }
                              )
                            ),
                          ]
                        ),
                        Positioned( //Navbar
                          bottom: 0,
                          child: Navbar(),
                        ),
                      ]
                    ),
                  );
                }
              ),
              // bottomNavigationBar: Navbar(),
            );
          }
        ),
      ),
    );
  }
}
