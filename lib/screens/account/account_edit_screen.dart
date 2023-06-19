import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:the_wallet/screens/components/close_button_account.dart';
import 'package:uuid/uuid.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/screens/components/navbar_top_account.dart';
import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/screens/account/account_main_screen.dart';
import 'package:the_wallet/screens/account/account_edit_email_screen.dart';
import 'package:the_wallet/screens/account/account_edit_phone_screen.dart';

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
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    setControllers();
    if (_userDataProvider.userData.pictureUrl != '') {
      profilePicture = Image.network(_userDataProvider.userData.pictureUrl!);
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
    textEditingControllers[0].text = _userDataProvider.userData.fname!;
    textEditingControllers[1].text = _userDataProvider.userData.lname!;
    textEditingControllers[2].text = _userDataProvider.userData.email!;
    textEditingControllers[3].text = _userDataProvider.userData.phoneNo!;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    late XFile? pickedImage;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedImage == null) return;

    profilePictureNew = File(pickedImage.path);
    profilePicture = Image.file(profilePictureNew!);

    updatePicture.value = !updatePicture.value;
  }

  Future<void> uploadImage(File file) async {
    const uuid = Uuid();
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('files/${uuid.v4()}_${path.basename(file.path)}');
    try {
      await ref.putFile(file);
      // Retrieve the download link from the snapshot
      downloadUrl = await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImageToFirebaseStorage(
      String url, String oldPictureUrl) async {
    if (profilePictureNew != null) {
      // Upload the new picture to Firebase Storage
      await uploadImage(profilePictureNew!);
      url = downloadUrl;
      if (oldPictureUrl != '') {
        try {
          await storage.refFromURL(oldPictureUrl).delete();
        } catch (e) {
          rethrow;
        }
      }
    } else {
      url = oldPictureUrl;
    }
    return url;
  }

  Future<void> updateSocialCardDataInProvider(
      String firstName, String lastName, String url) async {
    _userDataProvider.userData.setData(
      fname: firstName,
      lname: lastName,
      email: _userDataProvider.userData.email,
      phoneNo: _userDataProvider.userData.phoneNo,
      pictureUrl: url,
    );
  }

  Future<void> updateSocialCardDataInFirebaseFirestore(
      String firstName, String lastName, String url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
      {
        'pictureUrl': url,
        if (firstName.isNotEmpty) 'fname': firstName,
        if (lastName.isNotEmpty) 'lname': lastName,
      },
    );
  }

  void onSaveButtonPressed() async {
    String firstName = textEditingControllers[0].text;
    String lastName = textEditingControllers[1].text;
    String oldPictureUrl = _userDataProvider.userData.pictureUrl!;
    String url = '';

    url = await uploadImageToFirebaseStorage(url, oldPictureUrl);

    // Reset the profilePictureNew
    profilePictureNew = null;

    // Update the user data in the provider
    updateSocialCardDataInProvider(firstName, lastName, url);

    // Update the user data in Firestore
    try {
      await updateSocialCardDataInFirebaseFirestore(firstName, lastName, url);
    } catch (e) {
      rethrow;
    }

    if (firstName.isNotEmpty | lastName.isNotEmpty) {
      navigateToPage(AccountMain(), -1.0);
    }
  }

  void navigateToPage(Widget page, double offSet) {
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
                      isFieldEmpty = value.isEmpty;
                    });
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
        navigateToPage(page, 1.0);
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
      backgroundColor: primaryAccountColor,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: primaryAccountColor,
          body: Stack(
            children: [
              //****CLOSE ICON****//
              buildCloseButton(context),
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
                              backgroundColor: const Color(0xB3000000),
                              child: ValueListenableBuilder<bool>(
                                valueListenable: updatePicture,
                                builder: (context, value, child) {
                                  return profilePicture == null
                                      ? const Icon(Icons.person_rounded,
                                          color: primaryAccountColor,
                                          size: 60.0)
                                      : CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage:
                                              profilePicture!.image,
                                        );
                                },
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
                    buildInputRowEmailPhone(
                        context,
                        AccountEditEmail(
                            pictureUrl: _userDataProvider.userData.pictureUrl!),
                        'Email',
                        textEditingControllers[2],
                        'Email',
                        'email'),
                    //**** PHONE NUMBER ****//
                    buildInputRowEmailPhone(
                        context,
                        AccountEditPhone(
                            pictureUrl: _userDataProvider.userData.pictureUrl!),
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
                leftButtonBackgroundColor: closeBackColor,
                leftButtonIcon: Icons.arrow_back,
                leftButtonIconColor: const Color(0xFFFFFFFF),
                onLeftButtonPressed: () {
                  navigateToPage(AccountMain(), -1.0);
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
