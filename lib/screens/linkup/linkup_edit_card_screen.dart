import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data_classes/social_card_data.dart';
import 'package:the_wallet/data_classes/user_data.dart';

class EditSocialCard extends StatefulWidget {
  const EditSocialCard({Key? key}) : super(key: key);

  @override
  EditSocialCardState createState() => EditSocialCardState();
}

class EditSocialCardState extends State<EditSocialCard> {
  //Generate the controllers for the text fields
  final List<TextEditingController> textEditingControllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  //Initialize and Declare the variables
  late SocialCardDataProvider socialCardDataProvider;
  late UserDataProvider userDataProvider;
  String downloadUrl = '';
  Image? profilePicture;
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    socialCardDataProvider =
        Provider.of<SocialCardDataProvider>(context, listen: false);
    userDataProvider = Provider.of<UserDataProvider>(context);
    // Update the controllers with the data from firestore
    setControllers();
    // Update the profile picture
    if (socialCardDataProvider.socialCardData.pictureUrl != '') {
      profilePicture =
          Image.network(socialCardDataProvider.socialCardData.pictureUrl);
    }
    isLoading.value = false;
  }

  void setControllers() {
    textEditingControllers[0].text =
        socialCardDataProvider.socialCardData.fname;
    textEditingControllers[1].text =
        socialCardDataProvider.socialCardData.lname;
    textEditingControllers[2].text =
        socialCardDataProvider.socialCardData.career;
    textEditingControllers[3].text = socialCardDataProvider.socialCardData.age;
    textEditingControllers[4].text =
        socialCardDataProvider.socialCardData.email;
    textEditingControllers[5].text =
        socialCardDataProvider.socialCardData.phoneNo;
    textEditingControllers[6].text =
        socialCardDataProvider.socialCardData.linkedIn;
    textEditingControllers[7].text =
        socialCardDataProvider.socialCardData.twitter;
    textEditingControllers[8].text =
        socialCardDataProvider.socialCardData.instagram;
    textEditingControllers[9].text =
        socialCardDataProvider.socialCardData.facebook;
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

    //Update the UI for the new profile picture
    updatePicture.value = !updatePicture.value;
  }

  Future<void> updateSocialCardDataInProvider(String url) async {
    socialCardDataProvider.socialCardData.setData(
        textEditingControllers[0].text,
        textEditingControllers[1].text,
        textEditingControllers[2].text,
        textEditingControllers[3].text,
        textEditingControllers[4].text,
        textEditingControllers[5].text,
        textEditingControllers[6].text,
        textEditingControllers[7].text,
        textEditingControllers[8].text,
        textEditingControllers[9].text,
        url);
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

  Future<void> updateSocialCardDatainFirebaseFirestore(String url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cards')
        .doc(userDataProvider.userData.socialCardId!)
        .update({
      'fname': textEditingControllers[0].text,
      'lname': textEditingControllers[1].text,
      'career': textEditingControllers[2].text,
      'age': textEditingControllers[3].text,
      'email': textEditingControllers[4].text,
      'phoneNo': textEditingControllers[5].text,
      'linkedin': textEditingControllers[6].text,
      'twitter': textEditingControllers[7].text,
      'instagram': textEditingControllers[8].text,
      'facebook': textEditingControllers[9].text,
      'pictureUrl': url,
    });
  }

  void showSnackBar(String message, Color backgroundColor,
      {SnackBarAction? action}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
      backgroundColor: backgroundColor,
      action: action,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onSaveButtonPressed() async {
    String oldPictureUrl = socialCardDataProvider.socialCardData.pictureUrl;
    String url = '';
    // Upload the image to Firebase Storage and return the updated URL
    url = await uploadImageToFirebaseStorage(url, oldPictureUrl);
    // Reset the profilePictureNew
    profilePictureNew = null;
    // Update the user data in the provider
    updateSocialCardDataInProvider(url);
    // Update the user data in Firestore
    try {
      await updateSocialCardDatainFirebaseFirestore(url);
      // Show success SnackBar
      showSnackBar('Changes saved successfully!', linkUpMain);
    } catch (e) {
      // Show error SnackBar
      showSnackBar('Error saving changes.', Colors.grey);
    }
  }

  Widget buildInputRow(
      String label, TextEditingController controller, String hintText) {
    return SizedBox(
      height: 40,
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
            child: TextField(
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              controller: controller,
              style: const TextStyle(
                color: Color(0xBFFFFFFF),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xBFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDividerInput() {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0x80FFFFFF),
    );
  }

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle asynchronous loading of data
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return const Scaffold(
            backgroundColor: linkUpMain,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Data has been loaded, build the UI
          return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: CircleAvatar(
                                radius: 41.5,
                                backgroundColor: const Color(0xCCFFFFFF),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: updatePicture,
                                  builder: (context, value, child) {
                                    return profilePicture == null
                                        ? const Icon(Icons.person_rounded,
                                            color: linkUpMain, size: 60.0)
                                        : CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage:
                                                profilePicture!.image,
                                          );
                                  },
                                ),
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: isLoading,
                              builder: (context, value, child) {
                                return value
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1.2),
                                borderRadius: BorderRadius.circular(50)),
                            child: const CircleAvatar(
                              radius: 12.5,
                              backgroundColor: Color(0xCCFFFFFF),
                              child: Icon(
                                Icons.edit,
                                color: linkUpMain,
                                size: 15,
                              ),
                            ),
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
                    'Enter First Name'),
                buildDividerInput(),
                buildInputRow(
                    'Last Name', textEditingControllers[1], 'Enter Last Name'),
                buildDividerInput(),
                buildInputRow(
                    'Career', textEditingControllers[2], 'Enter Career'),
                buildDividerInput(),
                buildInputRow(
                  'Age',
                  textEditingControllers[3],
                  'Enter Age',
                ),
                buildDividerInput(),
                buildInputRow(
                    'Email', textEditingControllers[4], 'Enter Email'),
                buildDividerInput(),
                buildInputRow('Phone Number', textEditingControllers[5],
                    'Enter Phone Number'),
                buildDividerInput(),
                buildInputRow(
                    'LinkedIn', textEditingControllers[6], 'LinkedIn'),
                buildDividerInput(),
                buildInputRow('Twitter', textEditingControllers[7], 'Twitter'),
                buildDividerInput(),
                buildInputRow(
                    'Instagram', textEditingControllers[8], 'Instagram'),
                buildDividerInput(),
                buildInputRow(
                    'Facebook', textEditingControllers[9], 'Facebook'),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xCCFFFFFF),
                  ),
                  child: TextButton(
                    onPressed: () {
                      onSaveButtonPressed();
                    },
                    child: const Text(
                      'Save Changes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: linkUpMain,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
