import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {
  String userID;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  File? picture;

  UserClass({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.picture,
  });

  static UserClass? currentUser; // Static instance to store the current user

  factory UserClass.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserClass(
      userID: snapshot.id,
      firstName: data['firstN'],
      lastName: data['lastN'],
      email: data['email'],
      phoneNumber: data['phoneNo'],
    );
  }
}

final UserClass user = UserClass(
  userID: "E3422089-U7G11C",
  firstName: "Maneth",
  lastName: "Weerasinghe",
  email: "manethweerasinghe@gmail.com",
  phoneNumber: "077 123 4567",
);
