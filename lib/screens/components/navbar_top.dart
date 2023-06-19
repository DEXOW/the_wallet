import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/main.dart';
import 'package:the_wallet/screens/account/account_main_screen.dart';
// import 'package:the_wallet/screens/account/account_main_screen.dart';
import 'package:the_wallet/screens/components/dropdown_menu_linkup.dart';

const profileBackgroundColor = Color(0xCCFFFFFF);

final GlobalKey<BuildDropDownMenuState> _dropdownMenuKey = GlobalKey();

Widget buildBackButton(BuildContext context) {
  final GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_rounded,
      color: Color(0xFFFFFFFF),
    ),
    onPressed: () {
      globalProvider.setCurrentScreen('linkup');
    },
    iconSize: 25.0,
    color: linkUpMain,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}

Widget buildProfileButton(BuildContext context) {
  return CircleAvatar(
    radius: 22,
    backgroundColor: profileBackgroundColor,
    child: IconButton(
      icon: const Icon(
        Icons.person_rounded,
        color: linkUpMain,
      ),
      onPressed: () {
        _dropdownMenuKey.currentState?.removeOverlaysAccount();
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) =>
                AccountMain(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, -1.0);
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
      iconSize: 22.0,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
  );
}

Widget buildBackAndProfileButtons(BuildContext context) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildBackButton(context),
      buildProfileButton(context),
    ],
  );
}

Widget buildDropDownMenuOnly(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      BuildDropDownMenu(key: _dropdownMenuKey),
    ],
  );
}

