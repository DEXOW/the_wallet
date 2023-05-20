import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wallet/screens/linkup/edit-social-card-screen.dart';
import 'package:the_wallet/screens/linkup/social-card-data-provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/userDataProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
            create: (_) => UserDataProvider()),
        ChangeNotifierProvider<SocialCardDataProvider>(
            create: (_) => SocialCardDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  login('manethweerasinghe@gmail.com', 'Maneth1234');
  return firebaseApp;
}

Future<void> login(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('User ID: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  // FirebaseAuth auth = FirebaseAuth.instance;

  // final snapshot = await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc('${auth.currentUser!.uid}/cards/socialcard')
  //     .snapshots()
  //     .first;

  //     //set the data of the pictureUrl in snapshot.data to empty string
  //      await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('${auth.currentUser!.uid}/cards/socialcard')
  //         .update({
  //       'pictureUrl': '',
  //     });

  // print('THIS IS SNAPSHOT DATA: ${snapshot.data()}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wallet',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: linkUpMain,
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
