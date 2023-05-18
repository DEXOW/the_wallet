import 'package:flutter/material.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/account/user.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/screens/account/account-edit-screen.dart';

class AccountEditPhone extends StatefulWidget {
  const AccountEditPhone({Key? key}) : super(key: key);

  @override
  AccountEditPhoneState createState() => AccountEditPhoneState();
}

class AccountEditPhoneState extends State<AccountEditPhone> {
  final RegExp phoneRegex = RegExp(r'(?:(?:\+94|0)[1-9]\d{8})');

  bool isPhoneValid = false;
  String phoneValidationText = 'Please enter new phone number';
  Color phoneValidationColor = Colors.grey;

  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  bool showError = false;

  void onTextChanged(
      String value, int index, List<TextEditingController> controllers) {
    if (value.isNotEmpty && index < controllers.length - 1) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }

    if (index == controllers.length - 1 && value.isNotEmpty) {
      final otp = controllers.map((c) => c.text).join();
      submitOtp(otp);
    }
  }

  void submitOtp(String otp) {
    // Implement your OTP submission logic here
    // If the OTP is incorrect, set showError to true and call setState
    // setState(() {
    //   showError = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: accountMain,
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, left: 24),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: closeColor,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: secondaryColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 190, left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 41.5,
                      backgroundColor: const Color(0xB3000000),
                      child: user.picture == null
                          ? const Icon(Icons.person_rounded,
                              color: accountMain, size: 60.0)
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: FileImage(user.picture!),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(
                        user.userID,
                        style: const TextStyle(
                          color: Color(0xAA424242),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: tertiraryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              color: tertiraryColor,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                // validate email input using regex
                                isPhoneValid = phoneRegex.hasMatch(value);

                                // set validation display and icon based on email input
                                if (value.isEmpty) {
                                  phoneValidationText = 'Enter phone number';
                                  phoneValidationColor = Colors.red;
                                } else if (isPhoneValid) {
                                  phoneValidationText = 'Valid phone number';
                                  phoneValidationColor = Colors.green;
                                } else {
                                  phoneValidationText = 'Invalid phone number';
                                  phoneValidationColor = Colors.red;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        isPhoneValid
                            ? const Icon(Icons.check,
                                color: Colors.green, size: 20)
                            : const Icon(Icons.clear,
                                color: Colors.red, size: 20),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        phoneValidationText,
                        style: TextStyle(
                          color: phoneValidationColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(256, 37)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xD3A1A1A1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Request OTP",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          child: const Text(
                            "OTP",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.5),
                        Row(
                          children: List.generate(
                            4,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 12.5),
                              child: SizedBox(
                                width: 30,
                                child: Semantics(
                                  label: 'OTP digit ${index + 1}',
                                  child: TextField(
                                    controller: controllers[index],
                                    onChanged: (value) => onTextChanged(
                                        value, index, controllers),
                                    maxLength: 1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding:
                                          const EdgeInsets.only(top: 20),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder:const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.3,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorText: showError &&
                                              index == controllers.length - 1
                                          ? 'Invalid OTP'
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 35, left: 15),
                          child: const Text(
                            "60s",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 10,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BottomButtons(
                leftButtonBackgroundColor: closeColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AccountEditProfile(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(-1.0, 0.0);
                        var end = const Offset(0, 0.0);
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                onRightButtonPressed: () {},
                rightButtonBackgroundColor: const Color(0x6024FF00),
                rightButtonIcon: Icons.check_rounded,
                rightButtonText: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
