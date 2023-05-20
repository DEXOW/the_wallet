import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/dropdown-menu.dart';
import 'package:the_wallet/Screens/components/navbar.dart';
import 'package:the_wallet/screens/linkup/social-card-data-provider.dart';

class ViewSocialCard extends StatelessWidget {
  const ViewSocialCard({super.key});

  @override
  Widget build(BuildContext context) {
    final socialCardDataProvider = Provider.of<SocialCardDataProvider>(context);

    FirebaseAuth auth = FirebaseAuth.instance;

    String getProperty(String propertyName) {
      switch (propertyName) {
        case 'email':
          return socialCardDataProvider.socialCardData.email.isNotEmpty
              ? socialCardDataProvider.socialCardData.email
              : 'Your Email';
        case 'phone':
          return socialCardDataProvider.socialCardData.phoneNo.isNotEmpty
              ? socialCardDataProvider.socialCardData.phoneNo
              : 'Your Phone Number';
        case 'linkedIn':
          return socialCardDataProvider.socialCardData.linkedIn.isNotEmpty
              ? socialCardDataProvider.socialCardData.linkedIn
              : 'https://www.linkedin.com';
        case 'twitter':
          return socialCardDataProvider.socialCardData.twitter.isNotEmpty
              ? socialCardDataProvider.socialCardData.twitter
              : 'https://www.twitter.com';
        case 'instagram':
          return socialCardDataProvider.socialCardData.instagram.isNotEmpty
              ? socialCardDataProvider.socialCardData.instagram
              : 'https://www.instagram.com';
        case 'facebook':
          return socialCardDataProvider.socialCardData.facebook.isNotEmpty
              ? socialCardDataProvider.socialCardData.facebook
              : 'https://www.facebook.com';
        default:
          return '';
      }
    }

    Widget buildSocialCardHeader() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 41.5,
            backgroundColor: Color(0xB3000000),
            child: socialCardDataProvider.socialCardData.pictureUrl.isEmpty
                ? const Icon(Icons.person_rounded,
                    color: accountMain, size: 60.0)
                : CircleAvatar(
                    radius: 40.0,
                    backgroundImage: Image.network(
                            socialCardDataProvider.socialCardData.pictureUrl)
                        .image,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${socialCardDataProvider.socialCardData.fname} ${socialCardDataProvider.socialCardData.lname}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      socialCardDataProvider.socialCardData.career.isNotEmpty
                          ? socialCardDataProvider.socialCardData.career
                          : "Your Career",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      socialCardDataProvider.socialCardData.age.isNotEmpty
                          ? '${socialCardDataProvider.socialCardData.age} y.o.'
                          : "Your Age",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildSocialCardRow(
      String iconPath,
      String propertyName,
      bool isLink,
    ) {
      String label = '';
      switch (propertyName) {
        case 'linkedIn':
          label = 'Click me for LinkedIn';
          break;
        case 'twitter':
          label = 'Click me for Twitter';
          break;
        case 'instagram':
          label = 'Click me for Instagram';
          break;
        case 'facebook':
          label = 'Click me for Facebook';
          break;
        default:
          break;
      }
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(1),
            child: Image.asset(
              iconPath,
              width: 29,
              height: 29,
            ),
          ),
          const SizedBox(width: 12),
          isLink
              ? InkWell(
                  onTap: () {
                    launch(getProperty(propertyName));
                  },
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Text(
                  getProperty(propertyName),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: linkUpMain,
          body: Stack(
            children: [
              // ... existing code ...
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc('${auth.currentUser!.uid}/cards/socialcard')
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

                  final data = snapshot.data?.data();

                  if (data == null) {
                    return Text('User data not found in Firestore.');
                  }

                  socialCardDataProvider.socialCardData.setData(
                    data['fname'] ?? '',
                    data['lname'] ?? '',
                    data['career'] ?? '',
                    data['age'] ?? '',
                    data['email'] ?? '',
                    data['phoneNo'] ?? '',
                    data['linkedIn'] ?? '',
                    data['twitter'] ?? '',
                    data['instagram'] ?? '',
                    data['facebook'] ?? '',
                    data['pictureUrl'] ?? '',
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 100.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 380,
                      child: Card(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 30),
                                child: buildSocialCardHeader(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                ),
                                child: Column(
                                  children: [
                                    buildSocialCardRow(
                                      'assets/icons/email.png',
                                      'email',
                                      false,
                                    ),
                                    const SizedBox(height: 8),
                                    buildSocialCardRow(
                                      'assets/icons/phone.png',
                                      'phone',
                                      false,
                                    ),
                                    const SizedBox(height: 8),
                                    buildSocialCardRow(
                                      'assets/icons/LinkedIn.png',
                                      'linkedIn',
                                      true,
                                    ),
                                    const SizedBox(height: 8),
                                    buildSocialCardRow(
                                      'assets/icons/twitter.png',
                                      'twitter',
                                      true,
                                    ),
                                    const SizedBox(height: 8),
                                    buildSocialCardRow(
                                      'assets/icons/instagram.png',
                                      'instagram',
                                      true,
                                    ),
                                    const SizedBox(height: 8),
                                    buildSocialCardRow(
                                      'assets/icons/facebook.png',
                                      'facebook',
                                      true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // ... existing code ...
              DropDown(
                bottomPadding: 0,
                topBarColor: linkUpMain,
              ),
              Positioned(
                bottom: 10,
                child: Navbar(currentPage: 'linkup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
