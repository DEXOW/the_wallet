import 'package:flutter/material.dart';
import 'package:the_wallet/screens/login/login_screen.dart';
import 'package:the_wallet/screens/register/register_screen.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: screenHeight * 0.1, // Gap from the top of the screen
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/icons/icon.png'),
                      width: 200,
                      height: 200,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10), 
                      child: const Text(
                        'The Wallet',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xE608B4F8),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.05, // Gap from the bottom of the screen
                child: Column(children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen()
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xE61469EF),
                      ),
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(230.0, 50.0),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inter',
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xD5606060),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(230.0, 50.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Inter',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.1),
                    child: const Text(
                      'Legal',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Color(0x8FCDCDCD),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Color(0x8FCDCDCD),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}