import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/main.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late GlobalProvider globalProvider;
  late String currentScreen;

  Map<String, String> navIcons = {
    'contactless': 'assets/icons/contactless-icon.png',
    'wallet': 'assets/icons/wallet-icon.png',
    'home': 'assets/icons/home-icon.png',
    'linkup': 'assets/icons/linkup-icon.png',
    'settings': 'assets/icons/settings-icon.png',
  };
  Color selectedColor = const Color(0xFF1568EF);
  Color unselectedColor = const Color(0xFF000000);
  
  navNavigator({required BuildContext context, required final destination}){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination), // Add animation
    );
  }

  @override
  void initState() {
    super.initState();
    currentScreen = 'home';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    globalProvider = Provider.of<GlobalProvider>(context);

    late double navWidth;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (MediaQuery.of(context).size.width < 410 && MediaQuery.of(context).size.width > 150) {
          navWidth = MediaQuery.of(context).size.width - 50;
        } else if (MediaQuery.of(context).size.width < 150){
          navWidth = 150;
        } else {
          navWidth = 360;
        }
        return Container(
          width: screenWidth,
          color: primaryBgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: navWidth,
                margin: const EdgeInsets.only(top: 0, bottom: 10, left: 25, right: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    navIcons.entries.length, 
                    (i) => GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = navIcons.keys.elementAt(i);
                          globalProvider.setCurrentScreen(currentScreen);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ImageIcon(
                          AssetImage(navIcons.values.elementAt(i)),
                          size: 30,
                          color: navIcons.keys.elementAt(i) == currentScreen ? selectedColor : unselectedColor,
                        ),
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}