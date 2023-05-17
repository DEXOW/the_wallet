// ignore_for_file: prefer_const_constructors
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:the_wallet/firebase/fire_auth.dart';
import 'package:the_wallet/screens/register/otp-screen.dart';
import 'package:the_wallet/validate.dart';
import 'package:the_wallet/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<int> validityArr = [0,0,0,0,0];

  final _registerFormP1Key = GlobalKey<FormState>();
  final _registerFormP2Key = GlobalKey<FormState>();
  final _registerFormP3Key = GlobalKey<FormState>();

  List<TextEditingController> controllers = [
    TextEditingController(), //FIrst Name
    TextEditingController(), //Last Name
    TextEditingController(), //Email
    TextEditingController(), //Password
    TextEditingController(), //Confirm Password
    TextEditingController(), //Birth Day
    TextEditingController(), //Birth Month
    TextEditingController(), //Birth Year
    TextEditingController(), //Phone Number Prefix
    TextEditingController(), //Phone Number
    TextEditingController(), //OPT1
    TextEditingController(), //OPT2
    TextEditingController(), //OPT3
    TextEditingController(), //OPT4
    TextEditingController(), //OTP5
    TextEditingController(), //OTP6
    ];
    // List<TextEditingController>.generate(11, (index) => TextEditingController()), //All the controllers


  void initState() {
    super.initState();
    
    setState(() {
      controllers[5].text = selectedDate.day.toString();
      controllers[6].text = selectedDate.month.toString();
      controllers[7].text = selectedDate.year.toString();

      controllers[8].text = '+94';
    });
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (int i = 0; i < controllers.length; i++){
      controllers[i].dispose();
    }
    super.dispose();
  }

  void onCodeSent(String verificationId, int? resendToken) async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => OtpScreen(verificationId: verificationId, resendToken: resendToken, controllers: controllers,)
    ));
  }

  final today = DateTime.now();
  DateTime selectedDate = DateTime(DateTime.now().year - minAllowedAge);

  Future<void> _selectDate(BuildContext context) async {
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
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          if (validityArr[0] == 0)
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
            margin: EdgeInsets.only(top: 10),
            child: Text(
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
            margin: EdgeInsets.only(top: 70),
            child: SizedBox(
              width: 230.0,
              child: TextFormField(
                controller: controllers[0],
                validator: (value) => Validate.validateRegName(name: value),
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
                controller: controllers[1],
                validator: (value) => Validate.validateRegName(name: value),
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
            margin: EdgeInsets.only(top: 40),
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
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
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
            margin: EdgeInsets.only(top: 10),
            child: Text(
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
                controller: controllers[2],
                validator: (value) => Validate.validateEmail(email: value),
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
                controller: controllers[3],
                validator: (value) => Validate.validateRegPassword(password: value),
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
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 230.0,
              child: TextFormField(
                controller: controllers[4],
                validator: (value) => Validate.validateRegConfPassword(password: controllers[3].text,confPassword: value),
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
                  hintText: 'Confirm Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color(0x5E606060),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.only(left: 5),
                    icon: Icon(Icons.arrow_back_ios),
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
                      bool accountCreated = await FireAuth.createUserWithEmailAndPassword(
                        email: controllers[2].text,
                        password: controllers[3].text,
                        context: context,
                      );
                      if (accountCreated){
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
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
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
            margin: EdgeInsets.only(top: 10),
            child: Text(
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
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Text(
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
                      margin: EdgeInsets.only(top: 10.0),
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
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "${controllers[5].text}  /",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "${controllers[6].text}  /",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      controllers[7].text,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.calendar_today, size: 22.0, color: Color(0xFF979797)),
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
                      margin: EdgeInsets.only(top: 20.0 ,bottom: 15.0),
                      child: Text(
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
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: secondaryBgColor,
                            ),
                            child: CountryCodePicker(
                              onChanged: (value) => {controllers[8].text = value.toString()},
                              initialSelection: 'LK',
                              favorite: ['+94'],
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
                                controller: controllers[9],
                                validator: (value) => Validate.validatePhoneNo(phoneNo: value),
                                keyboardType: TextInputType.number,
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
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color(0x5E606060),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.only(left: 5),
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        validityArr[1] = 0;
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_registerFormP3Key.currentState!.validate()){
                      FireAuth.verifyPhoneNumber(context: context, phoneNumber: controllers[8].text + controllers[9].text, onCodeSent: onCodeSent);
                      // setState(() {
                      //   validityArr[2] = 1;
                      // });
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
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
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