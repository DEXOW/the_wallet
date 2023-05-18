import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/screens/account/user.dart';
import 'package:the_wallet/screens/account/userDataProvider.dart';
import 'package:the_wallet/screens/account/account-edit-password-screen.dart';
import 'package:the_wallet/screens/account/account-edit-screen.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({super.key});

  @override
  AccountMainState createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  // bool _isLoading = true;
  late UserDataProvider _userDataProvider;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    testEmailPasswordSignIn('manethweerasinghe@gmail.com', 'Maneth1234');
  }

  Future<void> testEmailPasswordSignIn(String email, String password) async {
    try {

      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();

      // Update user data in provider
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null) {
          _userDataProvider.userData.setData(
              '${userData['fname']}',
              '${userData['lname']}',
              '${userData['email']}',
              '${userData['phoneNo']}',
              '${userData['pictureUrl']}');
        }
      } else {
        print('User data not found in Firestore.');
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
    } catch (e) {
      print('Error: ${e}');
    }
  }

  Widget buildButton(BuildContext context, Widget page, String buttonText) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                );
                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ),
          );
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(256, 37)),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF888888),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Color(0xFF000000),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: accountMain,
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, left: 24),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: closeColor,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: secondaryColor,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: Color(0xB3000000),
                      child: _userDataProvider.userData.pictureUrl == ''
                          ? const Icon(Icons.person_rounded,
                              color: accountMain, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: Image.network(
                                      _userDataProvider.userData.pictureUrl)
                                  .image,
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${_userDataProvider.userData.fname} ${_userDataProvider.userData.lname}",
                        style: const TextStyle(
                          color: tertiraryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${_userDataProvider.userData.email}',
                        style: const TextStyle(
                          color: tertiraryColor,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        user.userID,
                        style: const TextStyle(
                          color: Color(0xAA424242),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    buildButton(
                        context, const AccountEditProfile(), "Edit Profile"),
                    const SizedBox(height: 10),
                    buildButton(context, const AccountEditPassowrd(),
                        "Change Password"),
                    const SizedBox(height: 170),
                  ],
                ),
              ),
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
      ),
    );
  }
}
