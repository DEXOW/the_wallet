import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:the_wallet/data_classes/social_card_data.dart';
import 'package:the_wallet/firebase_options.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/startup/startup_screen.dart';

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return firebaseApp;
}

class GlobalProvider extends ChangeNotifier {
  String currentScreen = 'home';

  void setCurrentScreen(newCurrentScreen){
    currentScreen = newCurrentScreen;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserDataProvider()),
        ChangeNotifierProvider.value(value: GlobalProvider()),
        ChangeNotifierProvider.value(
        value: SocialCardDataProvider(),
      ),
      ],
      child: const MyApp(),
    )
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
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: primaryBgColor),
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return const StartupScreen();
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