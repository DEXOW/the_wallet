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
// }