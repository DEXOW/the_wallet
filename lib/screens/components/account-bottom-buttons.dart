import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';

class BottomButtons extends StatelessWidget {
  final Color leftButtonBackgroundColor;
  final IconData leftButtonIcon;
  final Color leftButtonIconColor;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;
  final Color rightButtonBackgroundColor;
  final IconData rightButtonIcon;
  final String rightButtonText;

  const BottomButtons({
    Key? key,
    required this.leftButtonBackgroundColor,
    required this.leftButtonIcon,
    required this.leftButtonIconColor,
    required this.onLeftButtonPressed,
    required this.onRightButtonPressed,
    required this.rightButtonBackgroundColor,
    required this.rightButtonIcon,
    required this.rightButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: leftButtonBackgroundColor,
            child: IconButton(
              icon: Icon(
                leftButtonIcon,
                color: leftButtonIconColor,
              ),
              onPressed: () {
                onLeftButtonPressed();
              },
              iconSize: 24.0,
              hoverColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(202, 45)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(rightButtonBackgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(rightButtonIcon, color: linkUpMain, size: 24.0),
                  SizedBox(width: 30),
                  Text(
                    rightButtonText,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
