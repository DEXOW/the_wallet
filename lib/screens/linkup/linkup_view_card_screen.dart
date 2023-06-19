import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/data_classes/social_card_data.dart';

class ViewSocialCard extends StatelessWidget {
  const ViewSocialCard({super.key});

  @override
  Widget build(BuildContext context) {
    final socialCardDataProvider = Provider.of<SocialCardDataProvider>(context);

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
            backgroundColor: linkUpMain,
            child: socialCardDataProvider.socialCardData.pictureUrl.isEmpty
                ? const Icon(Icons.person_rounded,
                    color: Color(0xFFD9D9D9), size: 60.0)
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
                  socialCardDataProvider.socialCardData.fname.isNotEmpty &&
                          socialCardDataProvider.socialCardData.lname.isNotEmpty
                      ? '${socialCardDataProvider.socialCardData.fname} ${socialCardDataProvider.socialCardData.lname}'
                      : 'Your Name',
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
          socialCardDataProvider.socialCardData.linkedIn.isNotEmpty
              ? label = 'Click me for LinkedIn'
              : label = 'No LinkedIn';
          break;
        case 'twitter':
          socialCardDataProvider.socialCardData.twitter.isNotEmpty
              ? label = 'Click me for Twitter'
              : label = 'No Twitter';
          break;
        case 'instagram':
          socialCardDataProvider.socialCardData.instagram.isNotEmpty
              ? label = 'Click me for Instagram'
              : label = 'No Instagram';
          break;
        case 'facebook':
          socialCardDataProvider.socialCardData.facebook.isNotEmpty
              ? label = 'Click me for Facebook'
              : label = 'No Facebook';
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

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 360,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15),
        margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          color: Color(0xCCFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
    );
  }
}
