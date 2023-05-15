import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/linkup/social-card-template.dart';

class SocialCardTemplate extends StatefulWidget {
  final SocialCard socialCard;
  SocialCardTemplate({required this.socialCard});

  @override
  SocialCardTemplateState createState() => SocialCardTemplateState();
}

class SocialCardTemplateState extends State<SocialCardTemplate>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    initAnimation();
  }

  void initAnimation() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget buildSocialCardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 41.5,
          backgroundImage: widget.socialCard.picture != null
              ? FileImage(widget.socialCard.picture!) as ImageProvider<Object>?
              : const AssetImage('assets/icons/profile_display.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.socialCard.firstName.isNotEmpty == true ? widget.socialCard.firstName : "First\u{00A0}Name"} ${widget.socialCard.lastName.isNotEmpty == true ? widget.socialCard.lastName : "Last\u{00A0}Name"}',
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
                    widget.socialCard.career.isNotEmpty
                        ? widget.socialCard.career
                        : "Your Career",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.socialCard.age.isNotEmpty
                        ? '${widget.socialCard.age} y.o.'
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
        return widget.socialCard.email.isNotEmpty ? widget.socialCard.email : 'Your Email';
      case 'phone':
        return widget.socialCard.phoneNumber.isNotEmpty
            ? widget.socialCard.phoneNumber
            : 'Your Phone Number';
      case 'linkedIn':
        return widget.socialCard.linkedIn.isNotEmpty
            ? widget.socialCard.linkedIn
            : 'https://www.linkedin.com/';
      case 'twitter':
        return widget.socialCard.twitter.isNotEmpty
            ? widget.socialCard.twitter
            : 'https://twitter.com/home';
      case 'instagram':
        return widget.socialCard.instagram.isNotEmpty
            ? widget.socialCard.instagram
            : 'https://www.instagram.com';
      case 'facebook':
        return widget.socialCard.facebook.isNotEmpty
            ? widget.socialCard.facebook
            : 'https://www.facebook.com';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Container(
          width: double.infinity,
          height: _animation.value * 250 + 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: linkUpSecondary,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 30.0,
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
                    physics: ClampingScrollPhysics(),
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
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
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
        ),
      ),
    );
  }
}
