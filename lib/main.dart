import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wallet/screens/linkup/edit-social-card-screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/userDataProvider.dart';
import 'package:the_wallet/screens/account/account-main-screen.dart';
import 'package:the_wallet/screens/linkup/social-card-template.dart';
import 'package:the_wallet/test.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserDataProvider(),
      child: const MyApp(),
    ),
  );
}

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _loginEmailPassword("manethweerasinghe@gmail.com", "Maneth1234");
  return firebaseApp;
}

Future<void> _loginEmailPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wallet',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(
                  'Error initializing Firebase: ${snapshot.error.toString()}');
              return const Text('Error initializing Firebase');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return const EditSocialCard();
            }
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            );
          },
        ),
      ),
    );
  }
}

// UserClass.currentUser?.firstName = '${userData['fname']}';
//         UserClass.currentUser?.lastName = '${userData['lname']}';
//         UserClass.currentUser?.email = '${userData['email']}';
//         UserClass.currentUser?.phoneNumber = '${userData['phoneNo']}';
//         print('${UserClass.currentUser?.firstName}');
//         print('${UserClass.currentUser?.lastName}');
//         print('${UserClass.currentUser?.email}');
//         print('${UserClass.currentUser?.phoneNumber}');