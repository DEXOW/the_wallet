import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/data_classes/studentID_data.dart';
import 'package:the_wallet/screens/components/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:the_wallet/data_classes/membershipID_data.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class MembershipIDFormScreen extends StatefulWidget {
  @override
  _MembershipIDFormScreenState createState() => _MembershipIDFormScreenState();
}

class _MembershipIDFormScreenState extends State<MembershipIDFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController memIDController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  // final TextEditingController cardTypeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Image? image;
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  late MembershipIDDataProvider _membershipIDDataProvider;

  String downloadUrl = '';

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _membershipIDDataProvider =
        Provider.of<MembershipIDDataProvider>(context, listen: false);
  }

// ---------selecting a date
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null && pickedDate != _selectedDate) {
    setState(() {
      _selectedDate = pickedDate;
      controller.text = _selectedDate.toString().split(' ')[0];
    });
  }
}

// ---------selecting an image
  Future getImage(ImageSource media) async {
    final ImagePicker _picker = ImagePicker();

    late XFile? pickedImage;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedImage == null) return;

    setState(() {
      imageFile = File(pickedImage!.path);
      image = Image.file(imageFile!);
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //  ---------uploading an image
  Future<void> uploadImage(File file) async {
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('files/${path.basename(file.path)}');

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

  // ---------submit forms
  Future<void> _submitForm() async {
    print(user);
    String url = '';
    if (image != null) {
      await uploadImage(imageFile!);
      url = downloadUrl;
    }

    // cardTypeController.text = '';

    _membershipIDDataProvider.userData.setData(
      orgNameController.text,
      _membershipIDDataProvider.userData.cardType,
      phoneNumController.text,
      firstNameController.text,
      lastNameController.text,
      memIDController.text,
      expiryDateController.text,
      url,
    );

    // Update the user data in Firestore
    DocumentReference cardDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cards')
        .doc();

    bool cardExists =
        await cardDocRef.get().then((snapshot) => snapshot.exists);

    if (cardExists) {
      try {
        await cardDocRef.update({
          'orgName': _membershipIDDataProvider.userData.orgName,
          'cardType': _membershipIDDataProvider.userData.cardType,
          'phoneNumber': _membershipIDDataProvider.userData.phoneNumber,
          'firstName': _membershipIDDataProvider.userData.firstName,
          'lastName': _membershipIDDataProvider.userData.lastName,
          'membershipIDNumber': _membershipIDDataProvider.userData.membershipIDNumber,
          'expiryDate': _membershipIDDataProvider.userData.expiryDate,
          'imageUrl': _membershipIDDataProvider.userData.imageUrl,
        });
        print('User data updated successfully.');
      } catch (e) {
        print('Error updating user data: $e');
      }
    } else {
      try {
        await cardDocRef.set({
          'orgName': _membershipIDDataProvider.userData.orgName,
          'cardType': _membershipIDDataProvider.userData.cardType,
          'phoneNumber': _membershipIDDataProvider.userData.phoneNumber,
          'firstName': _membershipIDDataProvider.userData.firstName,
          'lastName': _membershipIDDataProvider.userData.lastName,
          'membershipIDNumber': _membershipIDDataProvider.userData.membershipIDNumber,
          'expiryDate': _membershipIDDataProvider.userData.expiryDate,
          'imageUrl': _membershipIDDataProvider.userData.imageUrl,
        });
        print('User data updated successfully.');
      } catch (e) {
        print('Error updating user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Scaffold(
      backgroundColor: primaryBgColor,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: screenHeight * 0.005,
            left: 0,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: secondaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 35,
                  ),
                ),
                Image(
                  image: AssetImage('assets/icons/icon.png'),
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            ),
          Positioned(
            top: screenHeight * 0.05,
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.879,
                  height: screenHeight * 0.85,
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      // child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            myAlert();
                          },
                          child: Text(
                            'Upload Photo',
                            style: TextStyle(
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    imageFile!,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                            : Text(
                                "Select Image",
                                style: TextStyle(
                                    color: secondaryColor, fontSize: 14),
                              ),
                        SizedBox(height: 40),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Enter Organization Name',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'As mentioned in ID',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: orgNameController,
                          // Add validator as needed
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Enter Phone Number',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'As registered in the membership',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: phoneNumController,
                          // Add validator as needed
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Enter First Name',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'As mentioned in ID',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: firstNameController,
                          // Add validator as needed
                        ),
                        SizedBox(height: 30),
                         TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Enter Last Name',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'As mentioned in ID',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: lastNameController,
                          // Add validator as needed
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Enter membership ID Number',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'As mentioned in ID',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: memIDController,
                          // Add validator as needed
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          onTap: () => _selectDate(context, expiryDateController),
                          decoration: InputDecoration(
                            labelText: 'Select Expiry Date',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Tap to select date',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                            filled: true,
                            fillColor: Color(0x606060).withOpacity(0.37),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x606060).withOpacity(0.37)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          controller: expiryDateController,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 150),
                      ],
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              child: Navbar(),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
