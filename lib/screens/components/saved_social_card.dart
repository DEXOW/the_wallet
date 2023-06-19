import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wallet/constants.dart';

typedef DeleteCatdCallBack = Future<void> Function(int cardNo);

class SocialCardTemplate extends StatefulWidget {
  final String fname;
  final String lname;
  final String career;
  final String age;
  final String email;
  final String phoneNo;
  final String linkedin;
  final String twitter;
  final String instagram;
  final String facebook;
  final String pictureUrl;
  final int cardNo;
  final DeleteCatdCallBack deleteCard;

  const SocialCardTemplate({
    super.key,
    required this.fname,
    required this.lname,
    required this.career,
    required this.age,
    required this.email,
    required this.phoneNo,
    required this.linkedin,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.pictureUrl,
    required this.cardNo,
    required this.deleteCard,
  });

  @override
  SocialCardTemplateState createState() => SocialCardTemplateState();
}

class SocialCardTemplateState extends State<SocialCardTemplate>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    initAnimation();
  }

  void initAnimation() {
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  Widget buildSocialCardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 41.5,
            backgroundColor: linkUpMain,
            child: widget.pictureUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 40.0,
                    backgroundImage: Image.network(widget.pictureUrl).image,
                  )
                : const Icon(Icons.person_rounded,
                    color: Color(0xFFD9D9D9), size: 60.0)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.fname.isNotEmpty == true ? widget.fname : "First\u{00A0}Name"} ${widget.lname.isNotEmpty == true ? widget.lname : "Last\u{00A0}Name"}',
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
                    widget.career.isNotEmpty ? widget.career : "Career",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.age.isNotEmpty ? '${widget.age} y.o.' : "Age",
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
        widget.linkedin.isNotEmpty
            ? label = 'Click me for LinkedIn'
            : label = 'No LinkedIn';
        break;
      case 'twitter':
        widget.twitter.isNotEmpty
            ? label = 'Click me for Twitter'
            : label = 'No Twitter';
        break;
      case 'instagram':
        widget.instagram.isNotEmpty
            ? label = 'Click me for Instagram'
            : label = 'No Instagram';
        break;
      case 'facebook':
        widget.facebook.isNotEmpty
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

  String getProperty(String propertyName) {
    switch (propertyName) {
      case 'email':
        return widget.email.isNotEmpty ? widget.email : 'Email';
      case 'phone':
        return widget.phoneNo.isNotEmpty ? widget.phoneNo : 'Phone Number';
      case 'linkedIn':
        return widget.linkedin.isNotEmpty
            ? widget.linkedin
            : 'https://www.linkedin.com/';
      case 'twitter':
        return widget.twitter.isNotEmpty
            ? widget.twitter
            : 'https://twitter.com/home';
      case 'instagram':
        return widget.instagram.isNotEmpty
            ? widget.instagram
            : 'https://www.instagram.com';
      case 'facebook':
        return widget.facebook.isNotEmpty
            ? widget.facebook
            : 'https://www.facebook.com';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        width: double.infinity,
        height: animation.value * 250 + 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xCCFFFFFF),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15.0,
                  ),
                  child: buildSocialCardHeader(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: linkUpMain,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: toggleExpand,
                      iconSize: 25.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 120.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: linkUpMain,
                child: Transform.scale(
                  scale: 1.2,
                  child: IconButton(
                    onPressed: () async {
                      final bool? result = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Delete Social Card',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: const Color(0xDDFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // buttonPadding: EdgeInsets.all(20),
                            actionsPadding: const EdgeInsets.only(bottom: 20),
                            contentPadding: const EdgeInsets.all(20),
                            titlePadding: const EdgeInsets.only(top: 20),
                            insetPadding: const EdgeInsets.all(40),
                            content: const Text(
                              'Are you sure you want to delete this card?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            actions: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: linkUpMain,
                                      ),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: const Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            style: const ButtonStyle(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.transparent),
                                            ),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: linkUpMain,
                                      ),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: const Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(false);
                                            },
                                            style: const ButtonStyle(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              overlayColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.transparent),
                                            ),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      if (result == true) {
                        await widget.deleteCard(widget.cardNo);
                      }
                    },
                    icon: const Icon(Icons.delete),
                    iconSize: 14.5,
                    color: const Color(0xCCFFFFFF),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
