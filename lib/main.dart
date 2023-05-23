import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/firebase_options.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data-classes/user-data.dart';
import 'package:the_wallet/screens/startup/startup-screen.dart';

// import 'package:the_wallet/RSA.dart';

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return firebaseApp;
}

void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wallet',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: primaryBgColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      // home: StartupScreen(),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: primaryBgColor),
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