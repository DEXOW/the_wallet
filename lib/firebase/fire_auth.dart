// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FireAuth{
//   static Future<User?> signInUsingEmailPassword({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//       print("success");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print("usr-nf");
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('No user found for that email.'),
//           ),
//         );
//       } else if (e.code == 'wrong-password') {
//         print("wrong-pw");
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Wrong password provided for that user.'),
//           ),
//         );
//       }
//     }

//     return user;
//   }

//   static Future<User?> registerUsingEmailPassword({
//     required String fname,
//     required String lname,
//     required String email,
//     required String password,
//     required String confPassword,
//     required String dobDate,
//     required String dobMonth,
//     required String dobYear,
//     required String phoneNoCode,
//     required String phoneNo,
//     required String otp1,
//     required String otp2,
//     required String otp3,
//     required String otp4,
//   }) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//       await user!.updateDisplayName("$fname $lname");
//       await user.reload();
//       user = auth.currentUser;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//     return user;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static Future<String?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid;

    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;
      print("Registration successful. UID: $uid");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return uid;
  }
}
