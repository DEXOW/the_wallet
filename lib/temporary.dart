// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:flutter/animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _iconColorAnimation;
  late Animation<Color?> _containerColorAnimation;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry1;
  OverlayEntry? _overlayEntry2;
  bool _isExpanded = false;
  bool _isVisible = false;  

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _iconColorAnimation = ColorTween(
      begin: linkUpMain,
      end: Color(0xCCFFFFFF),
    ).animate(_animationController);

    _containerColorAnimation = ColorTween(
      begin: Color(0xCCFFFFFF),
      end: linkUpMain,
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {}); // Rebuild the widget when the animation values change.
    });

    initAnimation();
  }

  void initAnimation() {
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isVisible = !_isVisible;
      if (_isExpanded) {
        _animationController.forward();
        _showOverlay(context);
      } else {
        _animationController.reverse().then((_) {
          _overlayEntry1?.remove();
          _overlayEntry2?.remove();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildMenuItem(
    String label,
    IconData icon,
  ) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () {},
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
                          // Icons.supervisor_account_rounded,
                          icon,
                          color: Color(0xCCFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.pushReplacement();
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
    _overlayEntry1 = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 87.5,
          left: 0,
          right: 0,
          bottom: 0,
          child: Material(
            color: Colors.black.withOpacity(0.4),
          ),
        );
      },
    );

    _overlayEntry2 = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 100,
          left: 30,
          right: 18,
          child: Material(
            color: Colors.transparent,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Container(
                // padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                // width: 11,
                height: _animation.value * 370 + 0,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20.0),
                //   color: const Color(0xF2B5B5BD),
                // ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildMenuItem(
                          'View Saved Cards', Icons.people_alt_rounded),
                      const SizedBox(height: 15),
                      buildMenuItem('View Own Card', Icons.credit_card_rounded),
                      const SizedBox(height: 15),
                      buildMenuItem('Edit Card', Icons.edit_rounded),
                      const SizedBox(height: 15),
                      buildMenuItem('Scan QR', Icons.qr_code_scanner_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry1!);
    Overlay.of(context).insert(_overlayEntry2!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;
            return Container(
              // Top Section
              height: screenHeight * 0.1,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                        color: Color(0xCCFFFFFF),
                        width: 2.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: _containerColorAnimation.value,
                      radius: 20.0,
                      child: IconButton(
                        icon: Transform.scale(
                          scale: 1.2,
                          child: Icon(
                            _isExpanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: _iconColorAnimation.value,
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
