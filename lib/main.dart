<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:the_wallet/firebase_options.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/startup/startup-screen.dart';
import 'package:the_wallet/screens/components/loading-animation.dart';
import 'package:the_wallet/screens/components/loading-screen.dart';
import 'package:the_wallet/RSA.dart';
import 'package:the_wallet/screens/addCard/addCard-addOptions.dart';
import 'package:the_wallet/screens/addCard/addCard-cardType.dart';

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
  // runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/addCardOptions' :(context) => AddCardOptions(),
      '/addCardType' :(context) => AddCardType(),
    },
    home: AddCardType(),
  ));
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
        value: SystemUiOverlayStyle.light
            .copyWith(systemNavigationBarColor: bgColor),
        child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return StartupScreen();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:the_wallet/firebase_options.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/register/successful_screen.dart';
import 'package:the_wallet/screens/startup/startup_screen.dart';
import 'package:the_wallet/screens/home/home_screen.dart';
import 'package:the_wallet/screens/wallet/addcardoption_screen.dart';
import 'package:the_wallet/screens/wallet/cardadded_screen.dart';
import 'package:the_wallet/screens/wallet/wallet_screen.dart';
// import 'package:the_wallet/screens/wallet/wallet2_screen.dart';
import 'package:the_wallet/screens/forms/forms_studentID.dart';
import 'package:the_wallet/screens/forms/forms_membershipID.dart';
import 'package:the_wallet/screens/forms/forms__NIC.dart';
import 'package:the_wallet/data_classes/studentID_data.dart';
import 'package:the_wallet/data_classes/drivingID_data.dart';
import 'package:the_wallet/data_classes/NIC_data.dart';
import 'package:the_wallet/data_classes/membershipID_data.dart';

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return firebaseApp;
}

class GlobalProvider extends ChangeNotifier {
  String currentScreen = 'home';

  void setCurrentScreen(newCurrentScreen) {
    currentScreen = newCurrentScreen;
    notifyListeners();
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserDataProvider()),
      ChangeNotifierProvider.value(value: GlobalProvider()),
      ChangeNotifierProvider.value(value: StudentIDDataProvider()),
      ChangeNotifierProvider.value(value: DrivingIDDataProvider()),
      ChangeNotifierProvider.value(value: NICDataProvider()),
      ChangeNotifierProvider.value(value: MembershipIDDataProvider()),
    ],
    child: const MyApp(),
  ));
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
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(systemNavigationBarColor: primaryBgColor),
        child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // return StartupScreen();
                // return AddCardOptionsScreen();
                // return StudentIDFormScreen();
                // return MembershipIDFormScreen();
                // return NICFormScreen();
                // return HomeScreen();
                // return CardAddedScreen();
                return WalletScreen();

                // return SuccessScreen(controllers: controllers, credential: credential)
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
>>>>>>> main
