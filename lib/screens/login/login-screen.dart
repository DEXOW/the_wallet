import 'package:flutter/material.dart';

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
    //Login process
    dispose();
  }

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
                bottom: screenHeight * 0.05, // Gap from the bottom of the screen
                child: Column(
                  children: [
                    Container(
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
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
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
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}