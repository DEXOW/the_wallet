import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:the_wallet/firebase/fire_auth.dart';
import 'package:the_wallet/main.dart';

import 'package:the_wallet/screens/root/root_screen.dart';
import 'package:the_wallet/screens/login/reset_password.dart';
import 'package:the_wallet/validate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalProvider globalProvider;
  final _loginFormKey = GlobalKey<FormState>();
  late TextEditingController usrEmail;
  late TextEditingController usrPassword;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    usrEmail = TextEditingController();
    usrPassword = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usrEmail.dispose();
    usrPassword.dispose();
    super.dispose();
  }


  void login(BuildContext context) async {
    try{
      globalProvider = Provider.of<GlobalProvider>(context, listen: false);
      User? user = await FireAuth.signInUsingEmailPassword(email: usrEmail.text.trim(), password: usrPassword.text, context: context);
      if (user != null){
        globalProvider.setCurrentScreen('home');
        if (context.mounted){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootScreen()));
        }
      }
    } catch (e){
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      if (FirebaseAuth.instance.currentUser != null){
        FirebaseAuth.instance.signOut();
      }
    } catch (e){
      rethrow;
    }
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Image(
                            image: AssetImage('assets/icons/icon.png'),
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox( //Middle section
                      height: screenHeight * 0.8,
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
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
                              margin: const EdgeInsets.only(top: 70),
                              child: SizedBox(
                                width: 230.0,
                                child: TextFormField(
                                  controller: usrEmail,
                                  validator: (value) => Validate.validateEmail(email: value),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        style: BorderStyle.none,
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                                    hintText: 'Email',
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: 230.0,
                                child: TextFormField(
                                  controller: usrPassword,
                                  validator: (value) => Validate.validateLoginPassword(password: value),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                        style: BorderStyle.none,
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 20.0),
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      icon: Icon(
                                          _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                          color: const Color(0xFFCFC7BE),
                                          ),
                                      onPressed: () {
                                          setState(() {
                                              _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  obscureText: !_passwordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: TextButton(
                                onPressed: () {
                                  if (_loginFormKey.currentState!.validate()){
                                    login(context);
                                  }
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
                              margin: const EdgeInsets.only(top: 5),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ResetPasswordScreen(),
                                    ),
                                  );
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
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox( //Bottom Section
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
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