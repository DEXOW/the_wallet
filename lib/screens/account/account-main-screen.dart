import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/screens/account/user.dart';
import 'package:the_wallet/screens/account/userDataProvider.dart';
import 'package:the_wallet/screens/account/account-edit-password-screen.dart';
import 'package:the_wallet/screens/account/account-edit-screen.dart';
import 'package:the_wallet/screens/account/userTest.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({super.key});

  @override
  AccountMainState createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late Future<Map<String?, dynamic>> userDataMap;

  @override
  void initState() {
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: FutureBuilder(
        future: UserTest.getUserData(uid: FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error initializing Firebase: ${snapshot.error.toString()}');
            return const Text('Error initializing Firebase');
          } else if (snapshot.connectionState == ConnectionState.done) {
            print('THIS IS USERDATA ${snapshot.data!['fname']}');
            return SafeArea(
              child: Scaffold(
                backgroundColor: accountMain,
                body: Stack(
                  children: [
                    BottomButtons(
                      leftButtonBackgroundColor: const Color(0x5AFF0000),
                      leftButtonIcon: Icons.delete,
                      leftButtonIconColor: linkUpMain,
                      onLeftButtonPressed: () {},
                      onRightButtonPressed: () {},
                      rightButtonBackgroundColor: const Color(0x5AFF0000),
                      rightButtonIcon: Icons.logout,
                      rightButtonText: "Logout",
                    ),
                  ],
                ),
              ),
            );
          }
          return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          );
        },
      ),
    ),
  );
}

  // @override
  // Widget build(BuildContext context) {
  //   print('THIS IS USERDATA ${userDataMap}');
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Scaffold(
  //         backgroundColor: accountMain,
  //         body: Stack(
  //           children: [
  //             BottomButtons(
  //               leftButtonBackgroundColor: const Color(0x5AFF0000),
  //               leftButtonIcon: Icons.delete,
  //               leftButtonIconColor: linkUpMain,
  //               onLeftButtonPressed: () {},
  //               onRightButtonPressed: () {},
  //               rightButtonBackgroundColor: const Color(0x5AFF0000),
  //               rightButtonIcon: Icons.logout,
  //               rightButtonText: "Logout",
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
