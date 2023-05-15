import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/dropdown-menu.dart';
import 'package:the_wallet/Screens/components/navbar.dart';
import 'package:the_wallet/Screens/linkup/social-card-template.dart';


class ViewSocialCard extends StatefulWidget {
  const ViewSocialCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewSocialCardState createState() => _ViewSocialCardState();
}

class _ViewSocialCardState extends State<ViewSocialCard> {

  late SocialCardProvider _socialCardProvider;
  late SocialCard _socialCard;

  @override
  void initState() {
    super.initState();
    _socialCardProvider = SocialCardProvider();
    _socialCardProvider.init().then((_) {
      setState(() {
        _socialCard = _socialCardProvider.socialCard;
      });
    });
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: linkUpMain,
      ),
    );
  }

  Widget buildSocialCardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 41.5,
          backgroundImage: _socialCard.picture != null
              ? FileImage(_socialCard.picture!) as ImageProvider<Object>?
              : const AssetImage('assets/icons/profile_display.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_socialCard.firstName.isNotEmpty == true ? _socialCard.firstName : "First\u{00A0}Name"} ${_socialCard.lastName.isNotEmpty == true ? _socialCard.lastName : "Last\u{00A0}Name"}',
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
                    _socialCard.career.isNotEmpty
                        ? _socialCard.career
                        : "Your Career",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _socialCard.age.isNotEmpty
                        ? '${_socialCard.age} y.o.'
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

  String getProperty(String propertyName) {
    switch (propertyName) {
      case 'email':
        return _socialCard.email.isNotEmpty ? _socialCard.email : 'Your Email';
      case 'phone':
        return _socialCard.phoneNumber.isNotEmpty
            ? _socialCard.phoneNumber
            : 'Your Phone Number';
      case 'linkedIn':
        return _socialCard.linkedIn.isNotEmpty
            ? _socialCard.linkedIn
            : 'https://www.linkedin.com/';
      case 'twitter':
        return _socialCard.twitter.isNotEmpty
            ? _socialCard.twitter
            : 'https://twitter.com/home';
      case 'instagram':
        return _socialCard.instagram.isNotEmpty
            ? _socialCard.instagram
            : 'https://www.instagram.com';
      case 'facebook':
        return _socialCard.facebook.isNotEmpty
            ? _socialCard.facebook
            : 'https://www.facebook.com';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: linkUpMain,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  FutureBuilder(
                    future: _socialCardProvider.init(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
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
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 30),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            DropDown(bottomPadding: 0, topBarColor: linkUpMain,),
            Positioned(
              bottom: 10,
              child: Navbar(currentPage: 'linkup'),
            ),
          ],
        ),
      ),
    );
  }
}
