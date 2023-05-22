import 'dart:core';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:the_wallet/firebase/fire_auth.dart';
import 'package:the_wallet/firebase/fire_store.dart';
import 'package:the_wallet/screens/register/otp-screen.dart';
import 'package:the_wallet/validate.dart';
import 'package:the_wallet/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool _passwordVisible;

  late GlobalKey<FormState> _registerFormP1Key;
  late GlobalKey<FormState> _registerFormP2Key;
  late GlobalKey<FormState> _registerFormP3Key;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  late List<int> validityArr;

  late DateTime today;
  late DateTime selectedDate;


  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    validityArr = [0,0,0,0,0];

    _registerFormP1Key = GlobalKey<FormState>();
    _registerFormP2Key = GlobalKey<FormState>();
    _registerFormP3Key = GlobalKey<FormState>();

    controllers = List<TextEditingController>.generate(10, (index) => TextEditingController()); //All the controllers
    focusNodes = List<FocusNode>.generate(6, (index) => FocusNode()); //All the controllers

    today = DateTime.now();
    selectedDate = DateTime(DateTime.now().year - minAllowedAge);
    
    setState(() {
      controllers[5].text = selectedDate.day.toString();
      controllers[6].text = selectedDate.month.toString();
      controllers[7].text = selectedDate.year.toString();

      controllers[8].text = '+94';
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (var element in controllers) {
      element.dispose();
    }
    for (var element in focusNodes) {
      element.dispose();
    }
    super.dispose();
  }

  void onCodeSent(String verificationId, int? resendToken) async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => OtpScreen(verificationId: verificationId, resendToken: resendToken, controllers: controllers,)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area
            return Scaffold(
              resizeToAvoidBottomInset: false,
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
                          if (validityArr[0] == 0)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          Container(
                            child: const Image(
                              image: AssetImage('assets/icons/icon.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Middle section
                      height: screenHeight * 0.8,
                      child: LayoutBuilder(
                        builder:(BuildContext context, BoxConstraints constraints){
                          if (validityArr[0] == 0){
                            return view1();
                          } else if (validityArr[1] == 0){
                            return view2();
                          } else if (validityArr[2] == 0){
                            return view3();
                          } 
                          else {
                            return Container();
                          }
                        }
                      )
                    ),
                    //Middle Section (Widget will be loaded by layout builder depending on the view needed on the screen)
                    Container( //Bottom Section
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
              ),
            );
          }
        ) 
      ),
    );
  }

  Widget view1(){
    return Form(
      key: _registerFormP1Key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Auto adjust when keyboard is open
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Sign Up',
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
                focusNode: focusNodes[0],
                controller: controllers[0],
                validator: (value) => Validate.validateRegName(name: value),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term){
                  focusNodes[0].unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[1]);
                },
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
                  hintText: 'First Name',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 230.0,
              child: TextFormField(
                focusNode: focusNodes[1],
                controller: controllers[1],
                validator: (value) => Validate.validateRegName(name: value),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (term){
                  focusNodes[1].unfocus();
                },
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
                  hintText: 'Last Name',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: TextButton(
              onPressed: () {
                if (_registerFormP1Key.currentState!.validate()){
                  setState(() {
                    validityArr[0] = 1;
                  });
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget view2(){
    return Form(
      key: _registerFormP2Key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Sign Up',
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
                focusNode: focusNodes[2],
                controller: controllers[2],
                validator: (value) => Validate.validateEmail(email: value),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term){
                  focusNodes[2].unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[3]);
                },
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
                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0,right: 30.0),
                  hintText: 'Email Address',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 230.0,
              child: TextFormField(
                focusNode: focusNodes[3],
                controller: controllers[3],
                validator: (value) => Validate.validateRegPassword(password: value),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term){
                  focusNodes[3].unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[4]);
                },
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
                  contentPadding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
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
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 230.0,
              child: TextFormField(
                focusNode: focusNodes[4],
                controller: controllers[4],
                validator: (value) => Validate.validateRegConfPassword(password: controllers[3].text,confPassword: value),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (term){
                  focusNodes[4].unfocus();
                },
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
                  contentPadding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                  hintText: 'Confirm Password',
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
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0x5E606060),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 5),
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        validityArr[0] = 0;
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_registerFormP2Key.currentState!.validate()) {
                      bool accountExist = await FireStore.checkUserExist(context: context, email: controllers[2].text);
                      if (!accountExist){
                        setState(() {
                          validityArr[1] = 1;
                        });
                      }
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
                      const Size(190.0, 50.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget view3(){
    
    return Form(
      key: _registerFormP3Key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Color(0xE608B4F8)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: const Text(
                        "Date Of Birth",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFF979797)
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final today = DateTime.now();
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(today.year - minAllowedAge), 
                            firstDate: DateTime(today.year - 118),
                            lastDate: DateTime(today.year - minAllowedAge, today.month, today.day),
                          );
                          if (picked != null && picked != selectedDate){
                            setState(() {
                              selectedDate = picked;
                              controllers[5].text = selectedDate.day.toString();
                              controllers[6].text = selectedDate.month.toString();
                              controllers[7].text = selectedDate.year.toString();
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0x35717171),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(250.0, 50.0),
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                          overlayColor: MaterialStateProperty.all<Color>(
                            const Color(0x35717171),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: //maxwidth
                                  MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "${controllers[5].text}  /",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "${controllers[6].text}  /",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      controllers[7].text,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.calendar_today, size: 22.0, color: Color(0xFF979797)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20.0 ,bottom: 15.0),
                      child: const Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFF979797)
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: secondaryBgColor,
                            ),
                            child: CountryCodePicker(
                              onChanged: (value) => {controllers[8].text = value.toString()},
                              initialSelection: 'LK',
                              favorite: const ['+94'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              showFlagMain: false,
                              alignLeft: false,
                              backgroundColor: primaryBgColor,
                              dialogBackgroundColor: primaryBgColor,
                              barrierColor: secondaryBgColor,
                            ),
                          ),
                          Container(
                            child: SizedBox(
                              width: 175.0,
                              child: TextFormField(
                                focusNode: focusNodes[5],
                                controller: controllers[9],
                                validator: (value) => Validate.validatePhoneNo(phoneNo: value),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  focusNodes[5].unfocus();
                                },
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
                                  contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0,left: 30.0),
                                  hintText: '777 123 456',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0x5E606060),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 5),
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        validityArr[1] = 0;
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (controllers[9].text.startsWith('0')){
                      controllers[9].text = controllers[9].text.substring(1);
                    }
                    if (_registerFormP3Key.currentState!.validate()){
                      bool phoneExist = await FireStore.checkPhoneExist(context: context, phoneNo: controllers[8].text + controllers[9].text);
                      if (!phoneExist){
                        FireAuth.verifyPhoneNumber(context: context, phoneNumber: controllers[8].text + controllers[9].text, onCodeSent: onCodeSent);
                      }
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
                      const Size(190.0, 50.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}