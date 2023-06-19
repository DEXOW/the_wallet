// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_wallet/firebase/fire_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrEmail = TextEditingController();
  final usrPassword = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usrEmail.dispose();
    usrPassword.dispose();
    super.dispose();
  }

  void initState() {
    _passwordVisible = false;
  }

  void login(BuildContext context) {
    FireAuth.signInUsingEmailPassword(email: usrEmail.text, password: usrPassword.text, context: context);
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area
            return Scaffold(
              resizeToAvoidBottomInset: false, //Keyboard doesn't resize the screen
              body: SizedBox( //SizedBox to set the height and width of the Page
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            child: Image(
                              image: AssetImage('assets/icons/icon.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Middle section
                      // alignment: Alignment.center,
                      // padding: EdgeInsets.only(top: 50),
                      height: screenHeight * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   child: Image(
                          //     image: AssetImage('assets/icons/icon.png'),
                          //     height: 200,
                          //     width: 200,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Color(0xE608B4F8)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 70),
                            child: SizedBox(
                              width: 230.0,
                              child: TextFormField(
                                controller: usrEmail,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      width: 0,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                                  hintText: 'Email',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 230.0,
                              child: TextFormField(
                                controller: usrPassword,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none,
                                      width: 0,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                                  hintText: 'Password',
                                ),
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: TextButton(
                              onPressed: () {
                                login(context);
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
                                'Login',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: TextButton(
                              onPressed: () {
                                //Forgot password
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0x00000000),
                                ),
                                //Remove hover effects
                                overlayColor: MaterialStateProperty.all<Color>(
                                  const Color(0x00000000),
                                ),
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Inter',
                                  color: Color(0x8FCDCDCD),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Bottom Section
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
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
                        ],
                      ),
                    )
                  ],
                ),
              )
            );
          }
        ),
      ),
    );
  }
}
