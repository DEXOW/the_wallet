import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/dropdown_menu.dart';
import 'package:the_wallet/screens/components/navbar.dart';

class ViewSocialCard extends StatelessWidget {
  
    String firstname = '';
    String lastname = '';
    String career = '';
    String age = '';
    String phoneNo = '';
    String email = '';
    String linkedIn = '';
    String twitter = '';
    String instagram = '';
    String facebook = '';
    String pictureUrl = '';

  ViewSocialCard({Key? key, required this.firstname, required this.lastname, required this.career, required this.age, required this.phoneNo, required this.email, required this.linkedIn, required this.twitter, required this.instagram, required this.facebook, required this.pictureUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 330),
              child: Center(
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
    );

    String getProperty(String propertyName) {
      switch (propertyName) {
        case 'email':
          return email.isNotEmpty
              ? email
              : 'Your Email';
        case 'phone':
          return phoneNo.isNotEmpty
              ? phoneNo
              : 'Your Phone Number';
        case 'linkedIn':
          return linkedIn.isNotEmpty
              ? linkedIn
              : 'https://www.linkedin.com';
        case 'twitter':
          return twitter.isNotEmpty
              ? twitter
              : 'https://www.twitter.com';
        case 'instagram':
          return instagram.isNotEmpty
              ? instagram
              : 'https://www.instagram.com';
        case 'facebook':
          return facebook.isNotEmpty
              ? facebook
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
            child: pictureUrl.isEmpty
                ? const Icon(Icons.person_rounded,
                    color: Colors.white, size: 60.0)
                : CircleAvatar(
                    radius: 40.0,
                    backgroundImage: Image.network(
                            pictureUrl)
                        .image,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${firstname} ${lastname}',
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
                      career.isNotEmpty
                          ? career
                          : "Your Career",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      age.isNotEmpty
                          ? '${age} y.o.'
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

    return Container(
      width: double.infinity,
      height: 370,
      // margin: EdgeInsets.symmetric(horizontal: 20),
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
                padding: const EdgeInsets.only(left: 15, right: 15),
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
    );
  }
}