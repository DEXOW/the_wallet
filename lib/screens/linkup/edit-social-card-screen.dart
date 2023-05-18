import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/linkup/social-card-template.dart';
import 'package:the_wallet/Screens/components/navbar.dart';
import 'package:the_wallet/Screens/components/dropdown-menu.dart';

class EditSocialCard extends StatefulWidget {
  const EditSocialCard({Key? key}) : super(key: key);

  @override
  EditSocialCardState createState() => EditSocialCardState();
}

class EditSocialCardState extends State<EditSocialCard> {
  final List<TextEditingController> textEditingControllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  bool _isMenuOpen = false;

  SocialCard socialCard = SocialCard(
    firstName: '',
    lastName: '',
    career: '',
    age: '',
    email: '',
    phoneNumber: '',
    linkedIn: '',
    twitter: '',
    instagram: '',
    facebook: '',
    picture: null,
  );

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final socialCardJson = prefs.getString('socialCard');
    if (socialCardJson != null) {
      final jsonMap = json.decode(socialCardJson) as Map<String, dynamic>;
      setState(() {
        socialCard = SocialCard.fromJson(jsonMap);
        textEditingControllers[0].text = socialCard.firstName;
        textEditingControllers[1].text = socialCard.lastName;
        textEditingControllers[2].text = socialCard.career;
        textEditingControllers[3].text = socialCard.age;
        textEditingControllers[4].text = socialCard.email;
        textEditingControllers[5].text = socialCard.phoneNumber;
        textEditingControllers[6].text = socialCard.linkedIn;
        textEditingControllers[7].text = socialCard.twitter;
        textEditingControllers[8].text = socialCard.instagram;
        textEditingControllers[9].text = socialCard.facebook;
      });
    } else {
      setState(() {
        socialCard = SocialCard(
          firstName: '',
          lastName: '',
          career: '',
          age: '',
          email: '',
          phoneNumber: '',
          linkedIn: '',
          twitter: '',
          instagram: '',
          facebook: '',
          picture: null,
        );
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final socialCardJson = json.encode(socialCard.toJson());
    await prefs.setString('socialCard', socialCardJson);
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
      socialCard.picture = file;
    });
    await _saveData();
  }

  Widget buildInputRow(String label, TextEditingController controller,
      String hintText, String propertyName) {
    return SizedBox(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: linkUpSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      switch (propertyName) {
                        case 'firstName':
                          socialCard.firstName = value;
                          break;
                        case 'lastName':
                          socialCard.lastName = value;
                          break;
                        case 'career':
                          socialCard.career = value;
                          break;
                        case 'age':
                          socialCard.age = value;
                          break;
                        case 'email':
                          socialCard.email = value;
                          break;
                        case 'phoneNumber':
                          socialCard.phoneNumber = value;
                          break;
                        case 'linkedIn':
                          socialCard.linkedIn = value;
                          break;
                        case 'twitter':
                          socialCard.twitter = value;
                          break;
                        case 'instagram':
                          socialCard.instagram = value;
                          break;
                        case 'facebook':
                          socialCard.facebook = value;
                          break;
                      }
                    });
                    _saveData();
                  },
                  style: const TextStyle(
                    color: Color(0xBFFFFFFF),
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDividerInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: const Color(0x80FFFFFF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: linkUpMain,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: CircleAvatar(
                                  radius: 41.5,
                                  backgroundColor: accountMain,
                                  child: socialCard.picture == null
                                      ? const Icon(Icons.person_rounded,
                                          color: linkUpMain, size: 60.0)
                                      : CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage:
                                              FileImage(socialCard.picture!)),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/icons/edit.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Upload Photo',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildInputRow('First Name', textEditingControllers[0],
                          'Enter First Name', 'firstName'),
                      buildDividerInput(),
                      buildInputRow('Last Name', textEditingControllers[1],
                          'Enter Last Name', 'lastName'),
                      buildDividerInput(),
                      buildInputRow('Career', textEditingControllers[2],
                          'Enter Career', 'career'),
                      buildDividerInput(),
                      buildInputRow(
                          'Age', textEditingControllers[3], 'Enter Age', 'age'),
                      buildDividerInput(),
                      buildInputRow('Email', textEditingControllers[4],
                          'Enter Email', 'email'),
                      buildDividerInput(),
                      buildInputRow('Phone Number', textEditingControllers[5],
                          'Enter Phone Number', 'phoneNumber'),
                      buildDividerInput(),
                      buildInputRow('LinkedIn', textEditingControllers[6],
                          'LinkedIn', 'linkedIn'),
                      buildDividerInput(),
                      buildInputRow('Twitter', textEditingControllers[7],
                          'Twitter', 'twitter'),
                      buildDividerInput(),
                      buildInputRow('Instagram', textEditingControllers[8],
                          'Instagram', 'instagram'),
                      buildDividerInput(),
                      buildInputRow('Facebook', textEditingControllers[9],
                          'Facebook', 'facebook'),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            DropDown(
              bottomPadding: 0,
              topBarColor: Colors.transparent,
            ),
            Positioned(
              bottom: 10,
              child: Navbar(currentPage: 'linkup'),
            ),
          ],
        ),
      ),
    );
  }
}
