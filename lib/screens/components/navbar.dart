import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/main.dart';
import 'package:the_wallet/screens/components/data-classes.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late PageDataProvider pageDataProvider;
  late String currentPage;
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
    currentPage = 'home';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    pageDataProvider = Provider.of<PageDataProvider>(context);

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
                margin: const EdgeInsets.only(top: 15, bottom: 10, left: 25, right: 25),
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
                          currentPage = navIcons.keys.elementAt(i);
                          // pageDataProvider.setCurrentScreen(currentPage);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ImageIcon(
                          AssetImage(navIcons.values.elementAt(i)),
                          size: 30,
                          color: navIcons.keys.elementAt(i) == currentPage ? selectedColor : unselectedColor,
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