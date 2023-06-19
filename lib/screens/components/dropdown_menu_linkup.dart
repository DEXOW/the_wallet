// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_wallet/main.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/linkup/linkup_edit_card_screen.dart';
import 'package:the_wallet/screens/linkup/linkup_scan_qr_screen.dart';
import 'package:the_wallet/screens/linkup/linkup_view_card_screen.dart';
import 'package:the_wallet/screens/linkup/linkup_view_saved_cards_screen.dart';

class BuildDropDownMenu extends StatefulWidget {
  const BuildDropDownMenu({super.key});

  @override
  State<BuildDropDownMenu> createState() => BuildDropDownMenuState();
}

class BuildDropDownMenuState extends State<BuildDropDownMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  OverlayEntry? overlayEntry1;
  OverlayEntry? overlayEntry2;
  bool isExpanded = false;
  bool isVisible = false;

  late GlobalProvider globalProvider;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    animationController.addListener(() {
      setState(() {}); // Rebuild the widget when the animation values change.
    });

    initAnimation();
  }

  void initAnimation() {
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      isVisible = !isVisible;
      if (isExpanded) {
        animationController.forward();
        _showOverlay(context);
      } else {
        animationController.reverse().then((_) {
          overlayEntry1?.remove();
          overlayEntry2?.remove();
        });
      }
    });
  }

  void removeOverlaysAccount() {
    if (isExpanded) {
      setState(() {
        isExpanded = !isExpanded;
        isVisible = !isVisible;
        animationController.reverse();
        overlayEntry1?.remove();
        overlayEntry2?.remove();
      });
    }
  }

  void removeOverlays() {
    if (isExpanded) {
      setState(
        () {
          isExpanded = !isExpanded;
          isVisible = !isVisible;
          animationController.reverse().then(
            (_) {
              overlayEntry1?.remove();
              overlayEntry2?.remove();
            },
          );
        },
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void naviagtor(Widget page, String pageName) {
    removeOverlays();
    if (pageName == 'editsocialcard') {
      globalProvider.setCurrentScreen('linkupEditCard');
    } else if (pageName == 'viewsocialcard') {
      globalProvider.setCurrentScreen('linkupViewCard');
    } else if (pageName == 'savedsocialcard') {
      globalProvider.setCurrentScreen('linkupViewSavedCards');
    } else if (pageName == 'scanQR') {
      globalProvider.setCurrentScreen('linkupScanQR');
    }
  }

  Widget buildMenuItem(
      String label, IconData icon, Widget page, String pageName) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () {
          naviagtor(page, pageName);
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding:
                  EdgeInsets.only(top: 5, bottom: 5, left: 12.5, right: 52.5),
              decoration: BoxDecoration(
                color: Color(0xCCFFFFFF),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: linkUpMain,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: linkUpMain,
                    width: 2.0,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Color(0xCCFFFFFF),
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: linkUpMain,
                    radius: 20.0,
                    child: IconButton(
                      icon: Transform.scale(
                        scale: 1.3,
                        child: Icon(
                          icon,
                          color: Color(0xCCFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        naviagtor(page, pageName);
                      },
                      iconSize: 18.0,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    overlayEntry1 = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 90,
          left: 0,
          right: 0,
          bottom: 0,
          child: FadeTransition(
            opacity: animation,
            child: Material(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        );
      },
    );

    overlayEntry2 = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 100,
          left: 30,
          right: 18,
          child: Material(
            color: Colors.transparent,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => SizedBox(
                height: animation.value * 245 + 0,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildMenuItem(
                          'View Saved Cards',
                          Icons.people_alt_rounded,
                          SavedSocialCard(),
                          'savedsocialcard'),
                      const SizedBox(height: 15),
                      buildMenuItem('View Own Card', Icons.credit_card_rounded,
                          ViewSocialCard(), 'viewsocialcard'),
                      const SizedBox(height: 15),
                      buildMenuItem('Edit Card', Icons.edit_rounded,
                          EditSocialCard(), 'editsocialcard'),
                      const SizedBox(height: 15),
                      buildMenuItem('Scan QR', Icons.qr_code_scanner_rounded,
                          ScanQrCodeWidget(), 'scanQR'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry1!);
    Overlay.of(context).insert(overlayEntry2!);
  }

  @override
  Widget build(BuildContext context) {
    globalProvider = Provider.of<GlobalProvider>(context);
    return CircleAvatar(
      // backgroundColor: _containerColorAnimation.value,
      backgroundColor: Color(0xCCFFFFFF),
      radius: 20.0,
      child: IconButton(
        icon: Transform.scale(
          scale: 1.2,
          child: Icon(
            isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            color: linkUpMain,
          ),
        ),
        onPressed: () {
          toggleExpand();
        },
        iconSize: 24.0,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
