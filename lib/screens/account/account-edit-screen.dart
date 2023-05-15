import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/Screens/account/user.dart';
import 'package:the_wallet/Screens/account/account-main-screen.dart';
import 'package:the_wallet/Screens/account/account-edit-email-screen.dart';
import 'package:the_wallet/Screens/account/account-edit-phone-screen.dart';

class AccountEditProfile extends StatefulWidget {
  const AccountEditProfile({Key? key}) : super(key: key);

  @override
  AccountEditProfileState createState() => AccountEditProfileState();
}

class AccountEditProfileState extends State<AccountEditProfile> {
  final List<TextEditingController> textEditingControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  setControllers() {
    textEditingControllers[0].text = user.firstName;
    textEditingControllers[1].text = user.lastName;
    textEditingControllers[2].text = user.email;
    textEditingControllers[3].text = user.phoneNumber;
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    late File file;

    if (Platform.isWindows) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty) {
        file = File(result.files.single.path!);
      } else {
        return;
      }
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        file = File(image.path);
      } else {
        return;
      }
    }

    setState(() {
      user.picture = file;
    });
    // await _saveData();
  }

  void navigateToPage(BuildContext context, Widget page, double offSet) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(offSet, 0.0);
          var end = const Offset(0, 0.0);
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  Widget buildInputRow(String label, TextEditingController controller,
      String hintText, String propertyName) {
    bool isFieldEmpty = controller.text.isEmpty;
    return SizedBox(
      height: 45,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: tertiraryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.25),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      switch (propertyName) {
                        case 'firstName':
                          user.firstName = value;
                          break;
                        case 'lastName':
                          user.lastName = value;
                          break;
                      }
                    });
                    // _saveData();
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFF888888),
                      )),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              isFieldEmpty ? Icons.clear : Icons.check,
              color: isFieldEmpty ? Colors.red : Colors.green,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputRowEmailPhone(
      BuildContext context,
      Widget page,
      String label,
      TextEditingController controller,
      String hintText,
      String propertyName) {
    return GestureDetector(
      onTap: () {
        navigateToPage(context, page, 1.0);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: tertiraryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    switch (propertyName) {
                      case 'email':
                        user.email = value;
                        break;
                      case 'phoneNumber':
                        user.phoneNumber = value;
                        break;
                    }
                  });
                  // _saveData();
                },
                style: const TextStyle(
                  color: tertiraryColor,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                enabled: false,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.check,
              color: Colors.green,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: accountMain,
          body: Stack(
            children: [
              //****CLOSE ICON****//
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 41.5,
                              backgroundColor: Color(0xB3000000),
                              child: user.picture == null
                                  ? const Icon(Icons.person_rounded,
                                      color: accountMain, size: 60.0)
                                  : CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: FileImage(user.picture!),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 12.5,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    const SizedBox(height: 30),
                    //**** FIRST NAME ****//
                    buildInputRow('First Name', textEditingControllers[0],
                        'Cannot be empty', 'firstName'),
                    //**** LAST NAME ****//
                    buildInputRow('Last Name', textEditingControllers[1],
                        'Cannot be empty', 'lastName'),
                    //**** EMAIL ****//
                    buildInputRowEmailPhone(context, AccountEditEmail(), 'Email',
                        textEditingControllers[2], 'Email', 'email'),
                    //**** PHONE NUMBER ****//
                    buildInputRowEmailPhone(
                        context,
                        AccountEditPhone(),
                        'Phone Number',
                        textEditingControllers[3],
                        'Phone Number',
                        'phoneNumber'),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
              //**** BOTTOM BAR ****//
              BottomButtons(
                leftButtonBackgroundColor: closeColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  navigateToPage(context, AccountMain(), -1.0);
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
