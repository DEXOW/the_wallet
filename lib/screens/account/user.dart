import 'dart:io';

class User {
  String userID;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  File? picture;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.picture,
  });
}

final User user = User(
  userID: "E3422089-U7G11C",
  firstName: "Maneth",
  lastName: "Weerasinghe",
  email: "manethweerasinghe@gmail.com",
  phoneNumber: "077 123 4567",
);
