import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/firebase_options.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/linkUp/linkUp.dart';
import 'package:the_wallet/screens/startup/startup-screen.dart';
import 'package:the_wallet/screens/components/loading-animation.dart';
import 'package:the_wallet/screens/components/loading-screen.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/user-data.dart';

import 'package:the_wallet/RSA.dart';

// Future<FirebaseApp> _initializeFirebase() async {
//   FirebaseApp firebaseApp = await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   return firebaseApp;
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //RSA Encryption

  // List<int> textList = 'Hello World!'.codeUnits;
  // final cipherText = rsaEncrypt(public, Uint8List.fromList(textList));
  // final deciphertext = String.fromCharCodes(rsaDecrypt(private, cipherText));
  
  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserDataProvider()),
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
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wallet',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      // home: StartupScreen(),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: bgColor),
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return StartupScreen();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}