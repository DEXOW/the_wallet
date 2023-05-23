import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/account-bottom-buttons.dart';
import 'package:the_wallet/data_classes/userData.dart';
import 'package:the_wallet/screens/account/account-main-screen.dart';
import 'package:the_wallet/screens/account/account-edit-email-screen.dart';
import 'package:the_wallet/screens/account/account-edit-phone-screen.dart';

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

  late UserDataProvider _userDataProvider;
  String downloadUrl = '';
  Image? profilePicture;
  File? profilePictureFile;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    setControllers();
    if (_userDataProvider.userData.pictureUrl != '') {
      profilePicture = Image.network(_userDataProvider.userData.pictureUrl);
    }
  }

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  setControllers() {
    textEditingControllers[0].text = _userDataProvider.userData.fname;
    textEditingControllers[1].text = _userDataProvider.userData.lname;
    textEditingControllers[2].text = _userDataProvider.userData.email;
    textEditingControllers[3].text = _userDataProvider.userData.phoneNo;
  }

  Future<void> uploadImage(File file) async {
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('files/${path.basename(file.path)}');

    try {
      await ref.putFile(file);
      print('File uploaded successfully');
      // Retrieve the download link from the snapshot
      downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);
    } catch (e) {
      print('Error occurred during file upload: $e');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    late XFile? pickedImage;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedImage == null) return;

    setState(() {
      profilePictureFile = File(pickedImage!.path);
      profilePicture = Image.file(profilePictureFile!);
    });
  }

  void onSaveButtonPressed() async {
    String firstName = textEditingControllers[0].text;
    String lastName = textEditingControllers[1].text;
    String oldPictureUrl = _userDataProvider.userData.pictureUrl;
    String url = '';

    if (profilePictureFile != null) {
      // Upload the new picture to Firebase Storage
      await uploadImage(profilePictureFile!);
      url = downloadUrl;
      if (oldPictureUrl != '') {
        try {
          await storage.refFromURL(oldPictureUrl).delete();
          print('Old picture deleted successfully.');
        } catch (e) {
          print('Error deleting old picture: $e');
        }
      }
    } else if (oldPictureUrl != '') {
      url = oldPictureUrl;
    } else {
      url = '';
    }

    // Update the user data in the provider
    _userDataProvider.userData.setData(
      firstName,
      lastName,
      _userDataProvider.userData.email,
      _userDataProvider.userData.phoneNo,
      url,
    );

    // Update the user data in Firestore
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({
        'fname': firstName,
        'lname': lastName,
        'pictureUrl': url,
      });
      print('User data updated successfully.');
    } catch (e) {
      print('Error updating user data: $e');
    }

    navigateToPage(context, AccountMain(), -1.0);
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
                  onChanged: (value) {},
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
                onChanged: (value) {},
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
                              child: profilePicture == null
                                  ? const Icon(Icons.person_rounded,
                                      color: accountMain, size: 60.0)
                                  : CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: profilePicture!.image,
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
                      child: const Text(
                        "E3422089-U7G11C",
                        style: TextStyle(
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
                    buildInputRowEmailPhone(context, AccountEditEmail(),
                        'Email', textEditingControllers[2], 'Email', 'email'),
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
              BottomButtons(
                leftButtonBackgroundColor: closeColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  navigateToPage(context, AccountMain(), -1.0);
                },
                onRightButtonPressed: () {
                  onSaveButtonPressed();
                },
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
