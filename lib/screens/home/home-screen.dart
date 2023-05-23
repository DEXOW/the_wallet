// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/data-classes/user-data.dart';
import 'package:the_wallet/screens/login/login-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserDataProvider userDataProvider;

  @override
  void initState() {
    super.initState();

    if (auth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);

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
                stream: FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).snapshots(),
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
                    imgUrl: data['imgUrl'],
                  );
                  
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
                              height: screenHeight * 0.9,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  //All your content for the page goes in here (Green zone)
                                ],
                              )
                            ),
                          ]
                        ),
                        Positioned( //Navbar
                          bottom: 0,
                          child: Navbar(currentPage: 'home'),
                        ),
                      ]
                    ),
                  );
                }
              ),
            );
          }
        ),
      ),
    );
  }
}
