import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wallet/screens/register/register-screen.dart';

class FireAuth{
  bool otpSent = false;

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      print("success");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("usr-nf");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("wrong-pw");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      }
    }

    return user;
  }

  static Future<User?> registerUsingEmailPassword({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required String dobDate,
    required String dobMonth,
    required String dobYear,
    required String phoneNoCode,
    required String phoneNo,
    required PhoneAuthCredential phoneAuthCredential,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName("${fname.trim()} ${lname.trim()}");
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user!.uid).set({
      'fname': fname.trim(),
      'lname': lname.trim(),
      'email': email.trim(),
      'dobDate': dobDate.trim(),
      'dobMonth': dobMonth.trim(),
      'dobYear': dobYear.trim(),
      'phoneNoCode': phoneNoCode.trim(),
      'phoneNo': phoneNo.trim(),
    });

    return user;
  }

  static Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
    required Function onCodeSent,
  }) async {
    print("verifyPhoneNumber");
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print("verification completed");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification Completed'),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The provided phone number is not valid.'),
          ),
        );
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        print("timeout");
      },
    );
  }

}