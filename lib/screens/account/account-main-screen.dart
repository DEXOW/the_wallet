import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/data_classes/userData.dart';
import 'package:the_wallet/screens/account/account-edit-password-screen.dart';
import 'package:the_wallet/screens/account/account-edit-screen.dart';

class AccountMain extends StatelessWidget {
  const AccountMain({super.key});

  @override
  Widget build(BuildContext context) {
    final _userDataProvider = Provider.of<UserDataProvider>(context);

    FirebaseAuth auth = FirebaseAuth.instance;

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

    return Scaffold(
      backgroundColor: accountMain,
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
              // ... existing code ...
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final userData = snapshot.data?.data();

                  if (userData == null) {
                    return Text('User data not found in Firestore.');
                  }

                  _userDataProvider.userData.setData(
                    '${userData['fname']}',
                    '${userData['lname']}',
                    '${userData['email']}',
                    '${userData['phoneNo']}',
                    '${userData['pictureUrl']}',
                  );

                  return Center(
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
                          child: const Text(
                            "E3422089-U7G11C",
                            style: TextStyle(
                              color: Color(0xAA424242),
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        buildButton(context, const AccountEditProfile(),
                            "Edit Profile"),
                        const SizedBox(height: 10),
                        buildButton(context, const AccountEditPassowrd(),
                            "Change Password"),
                        const SizedBox(height: 170),
                      ],
                    ),
                  );
                },
              ),
              // ... existing code ...
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
