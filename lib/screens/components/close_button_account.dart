import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';


Widget buildCloseButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 24, left: 24),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: closeBackColor,
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
  );
}
