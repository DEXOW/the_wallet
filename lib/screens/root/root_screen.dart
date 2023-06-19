import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/main.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:the_wallet/screens/components/navbar_top.dart';
import 'package:the_wallet/screens/contactless_pay/contactless_pay_screen.dart';
import 'package:the_wallet/screens/linkup/linkup_screen.dart';
import 'package:the_wallet/screens/login/login_screen.dart';

import 'package:the_wallet/screens/home/home_screen.dart';
import 'package:the_wallet/screens/settings/settings_screen.dart';
import 'package:the_wallet/screens/wallet/wallet_screen.dart';

import '../linkup/linkup_edit_card_screen.dart';
import '../linkup/linkup_scan_qr_screen.dart';
import '../linkup/linkup_view_card_screen.dart';
import '../linkup/linkup_view_saved_cards_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of<UserDataProvider>(context);
    globalProvider = Provider.of<GlobalProvider>(context);

    if (auth.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => route.isFirst,
        );
      });
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leadingWidth: double.infinity,
              leading: Container(
                // Top Section
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: LayoutBuilder(
                  builder: (BuildContext context, Constraints constraints) {
                    if (globalProvider.currentScreen == 'linkupScanQR' ||
                        globalProvider.currentScreen == 'linkupEditCard' ||
                        globalProvider.currentScreen == 'linkupViewCard' ||
                        globalProvider.currentScreen ==
                            'linkupViewSavedCards') {
                      return buildBackAndProfileButtons(context);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: buildProfileButton(context),
                      );
                    }
                  },
                ),
              ),
              actions: [
                if (globalProvider.currentScreen == 'linkup' ||
                    globalProvider.currentScreen == 'linkupScanQR' ||
                    globalProvider.currentScreen == 'linkupEditCard' ||
                    globalProvider.currentScreen == 'linkupViewCard' ||
                    globalProvider.currentScreen == 'linkupViewSavedCards')
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: buildDropDownMenuOnly(context),
                  ),
              ],
            ),
            resizeToAvoidBottomInset:
                false, //Keyboard doesn't resize the screen
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double screenHeight =
                  constraints.maxHeight; // Get the height of the safe area
              double screenWidth =
                  constraints.maxWidth; // Get the width of the safe area
              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong :('),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child:
                            Text('No user data found. Please contact support.'),
                      );
                    }
                    Map<String, dynamic>? data = snapshot.data?.data();
                    if (data == null) {
                      return const Center(
                        child:
                            Text('No user data found. Please contact support.'),
                      );
                    }
                    userDataProvider.userData.setData(
                      fname: data['fname'],
                      lname: data['lname'],
                      email: data['email'],
                      dob: (data['dob'] as Timestamp).toDate(),
                      phoneNo: data['phoneNo'],
                      pictureUrl: data['pictureUrl'],
                      socialCardId: data['socialCardId'],
                    );

                    return SizedBox(
                      //SizedBox to set the height and width of the Page
                      height: screenHeight,
                      width: screenWidth,
                      child: Column(
                        children: [
                          Container(
                            // Middle section
                            height: screenHeight,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: LayoutBuilder(builder: (BuildContext context,
                                Constraints constraints) {
                              switch (globalProvider.currentScreen) {
                                case 'home':
                                  return const HomeScreen();
                                case 'contactless':
                                  return ContactlessPayScreen();
                                case 'wallet':
                                  return const WalletScreen();
                                case 'linkup':
                                  return const LinkUpScreen();
                                case 'linkupEditCard':
                                  return const EditSocialCard();
                                case 'linkupViewCard':
                                  return const ViewSocialCard();
                                case 'linkupViewSavedCards':
                                  return const SavedSocialCard();
                                case 'linkupScanQR':
                                  return const ScanQrCodeWidget();
                                case 'settings':
                                  return const SettingsScreen();
                                default:
                                  return const Center(
                                      child: Text('Invalid Screen'));
                              }
                            }),
                          ),
                        ],
                      ),
                    );
                  });
            }),
            bottomNavigationBar: const Navbar(),
          ),
        ),
      ),
    );
  }
}
