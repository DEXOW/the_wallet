import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/components/navbar.dart';
import 'package:the_wallet/Screens/components/dropdown-menu.dart';
import 'package:the_wallet/screens/linkup/social-card-data-provider.dart';

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

  bool isDataLoaded = false;
  late SocialCardDataProvider socialCardDataProvider;
  String downloadUrl = '';
  Image? profilePicture;
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   socialCardDataProvider =
  //       Provider.of<SocialCardDataProvider>(context, listen: false);
  //   if (socialCardDataProvider.socialCardData.pictureUrl != '') {
  //     profilePicture =
  //         Image.network(socialCardDataProvider.socialCardData.pictureUrl);
  //   }
  //   fetchData();
  // }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   setState(() {
  //     isDataLoaded = true;
  //   });
  // }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    socialCardDataProvider =
        Provider.of<SocialCardDataProvider>(context, listen: false);
    await fetchData();
    setState(() {
      isDataLoaded = true;
      if (socialCardDataProvider.socialCardData.pictureUrl != '') {
        profilePicture =
            Image.network(socialCardDataProvider.socialCardData.pictureUrl);
      }
    });
  }

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> fetchData() async {
    await updateSocialCardData(); // Wait for data to be fetched
    setControllers(); // Update the controllers with the fetched data
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

  Future<void> updateSocialCardData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('${auth.currentUser!.uid}/cards/socialcard')
          .snapshots()
          .first;

      print('THIS IS SNAPSHOT DATA: ${snapshot.data()}');

      final data = snapshot.data();
      if (data != null) {
        socialCardDataProvider.socialCardData.setData(
          data['fname'] ?? '',
          data['lname'] ?? '',
          data['career'] ?? '',
          data['age'] ?? '',
          data['email'] ?? '',
          data['phoneNo'] ?? '',
          data['linkedIn'] ?? '',
          data['twitter'] ?? '',
          data['instagram'] ?? '',
          data['facebook'] ?? '',
          data['pictureUrl'] ?? '',
        );
      }
    } catch (e) {
      print(e);
    }
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

    profilePictureNew = File(pickedImage!.path);
    profilePicture = Image.file(profilePictureNew!);

    //Update the UI
    updatePicture.value = !updatePicture.value;
  }

  Future<void> uploadImage(File file) async {
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('files/${file.path}');

    try {
      await ref.putFile(file);
      print('File uploaded successfully');
      // Retrieve the download link from the snapshot
      downloadUrl = await ref.getDownloadURL();
    } catch (e) {
      print('Error occurred during file upload: $e');
    }
  }

  void onSaveButtonPressed() async {
    String oldPictureUrl = socialCardDataProvider.socialCardData.pictureUrl;
    String url = '';

    final loadingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(linkUpSecondary),
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Saving changes...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        backgroundColor: linkUpMain,
      ),
    );

    // Upload the image to Firebase Storage
    url = await uploadImageToFirebaseStorage(url, oldPictureUrl);

    //Reset the profilePictureNew
    profilePictureNew = null;

    // Update the user data in the provider
    updateSocialCardDataInProvider(url);

    // Update the user data in Firestore
    try {
      updateSocialCardDatainFirebaseFirestore(url);

      // Hide the loading SnackBar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Show success SnackBar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Changes saved successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: linkUpSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          backgroundColor: linkUpMain,
        ),
      );
    } catch (e) {
      // Hide the loading SnackBar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Show error SnackBar
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error saving changes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          backgroundColor: Colors.grey,
        ),
      );
    }
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

  Future<String> uploadImageToFirebaseStorage(
      String url, String oldPictureUrl) async {
    if (profilePictureNew != null) {
      // Upload the new picture to Firebase Storage
      await uploadImage(profilePictureNew!);
      url = downloadUrl;
      if (oldPictureUrl != '') {
        try {
          await storage.refFromURL(oldPictureUrl).delete();
          print('Old picture deleted successfully.');
        } catch (e) {
          print('Error deleting old picture: $e');
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
        .doc('${auth.currentUser!.uid}/cards/socialcard')
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

  Widget buildInputRow(
      String label, TextEditingController controller, String hintText) {
    return SizedBox(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                  onChanged: (value) {},
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
          // Data has been loaded, build your UI
          return Scaffold(
            body: SafeArea(
              child: Scaffold(
                backgroundColor: linkUpMain,
                body: isDataLoaded
                    ? Stack(
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
                                                  backgroundColor:
                                                      Color(0xCCFFFFFF),
                                                  child: ValueListenableBuilder<
                                                      bool>(
                                                    valueListenable:
                                                        updatePicture,
                                                    builder: (context, value,
                                                        child) {
                                                      return profilePicture ==
                                                              null
                                                          ? const Icon(
                                                              Icons
                                                                  .person_rounded,
                                                              color: linkUpMain,
                                                              size: 60.0)
                                                          : CircleAvatar(
                                                              radius: 40.0,
                                                              backgroundImage:
                                                                  profilePicture!
                                                                      .image,
                                                            );
                                                    },
                                                  )),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                _pickImage();
                                              },
                                              child: const CircleAvatar(
                                                radius: 12.5,
                                                backgroundColor:
                                                    Color(0xFFFFFFFF),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: linkUpMain,
                                                  size: 15,
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
                                    buildInputRow(
                                        'First Name',
                                        textEditingControllers[0],
                                        'Enter First Name'),
                                    buildDividerInput(),
                                    buildInputRow(
                                        'Last Name',
                                        textEditingControllers[1],
                                        'Enter Last Name'),
                                    buildDividerInput(),
                                    buildInputRow(
                                        'Career',
                                        textEditingControllers[2],
                                        'Enter Career'),
                                    buildDividerInput(),
                                    buildInputRow(
                                      'Age',
                                      textEditingControllers[3],
                                      'Enter Age',
                                    ),
                                    buildDividerInput(),
                                    buildInputRow(
                                        'Email',
                                        textEditingControllers[4],
                                        'Enter Email'),
                                    buildDividerInput(),
                                    buildInputRow(
                                        'Phone Number',
                                        textEditingControllers[5],
                                        'Enter Phone Number'),
                                    buildDividerInput(),
                                    buildInputRow('LinkedIn',
                                        textEditingControllers[6], 'LinkedIn'),
                                    buildDividerInput(),
                                    buildInputRow('Twitter',
                                        textEditingControllers[7], 'Twitter'),
                                    buildDividerInput(),
                                    buildInputRow('Instagram',
                                        textEditingControllers[8], 'Instagram'),
                                    buildDividerInput(),
                                    buildInputRow('Facebook',
                                        textEditingControllers[9], 'Facebook'),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 35,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 50.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xCCFFFFFF),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          onSaveButtonPressed();
                                        },
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 2),
                                            Transform.scale(
                                              scale: 2,
                                              child: const Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: linkUpMain,
                                                size: 18,
                                              ),
                                            ),
                                            // const SizedBox(width: 10),
                                            const Expanded(
                                              child: Text(
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
                                            const SizedBox(width: 15)
                                          ],
                                        ),
                                      ),
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          );
        }
      },
    );
  }
}
