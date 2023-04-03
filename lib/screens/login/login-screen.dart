// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

bool _passwordVisible = false;
void initState() {
  _passwordVisible = false;
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false, //Keyboard doesn't resize the screen
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: screenHeight * 0.1,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/icon.png'),
                      width: 200,
                      height: 200,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xE608B4F8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.05,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: screenHeight * 0.1, left: 50.0, right: 50.0),
                      child: SizedBox(
                        width: 230.0,
                        child: TextFormField(
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
                            contentPadding: EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 30.0),
                            hintText: 'Username',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      child: SizedBox(
                        width: 230.0,
                        child: TextFormField(
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
                            contentPadding: EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 30.0),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xE61469EF),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(230.0, 50.0),
                          ),
                        ),
                        child: Text(
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
                      margin: EdgeInsets.only(top: screenHeight * 0.1),
                      child: Text(
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
                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Text(
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
        ),
      ),
    );
  }
}
