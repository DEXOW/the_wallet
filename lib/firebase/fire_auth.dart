import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_wallet/screens/components/global.dart';

String _verificationId = '';
int? _resendToken = 0;
class FireAuth {
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarNotify.showSnackBar(context: context, message: 'Invalid Email or Password', bgcolor: Colors.red, textColor: Colors.white);
      }
    }

    return user;
  }

  static Future<User?> registerUsingEmailPassword({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required String dob,
    required String phoneNoCode,
    required String phoneNo,
    required PhoneAuthCredential phoneAuthCredential,
    required context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String socialCardId = firestore.collection('users').doc().id;
    User? user;
    try {
      UserCredential userCredential;
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ).then((value) async{
        userCredential = value;
        user = userCredential.user;
        await user!.updateDisplayName("${fname.trim()} ${lname.trim()}");
        await user!.reload();
        user = auth.currentUser;
      }).then((value) async {
        await firestore.collection('users').doc(user!.uid).set({
          'fname': fname.trim(),
          'lname': lname.trim(),
          'email': email.trim(),
          'dob': DateTime.parse(dob.trim()),
          'phoneNoCode': phoneNoCode.trim(),
          'phoneNo': phoneNo.trim(),
          'pictureUrl': '',
          'socialCardId': socialCardId,
          'savedSocialCards': [],
          'recentCards': {},
        }).then((value) async {

          await firestore.collection('users').doc(user!.uid).collection('cards').doc(socialCardId).set({
            'cardId': socialCardId,
            'fname': fname.trim(),
            'lname': lname.trim(),
            'career': '',
            'age': DateTime(DateTime.now().year - DateTime.parse(dob).year).year.toString(),
            'email': email.trim(),
            'phoneNo': phoneNoCode.trim() + phoneNo.trim(),
            'linkedin': '',
            'twitter': '',
            'facebook': '',
            'instagram': '',
            'pictureUrl': '',
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      SnackBarNotify.showSnackBar(context: context, message: 'Something Went Wrong!', bgcolor: Colors.amber, textColor: Colors.black);
      throw Exception(e);
    }
    return user;
  }

  static Future<bool> verifyPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        if (context.mounted){
          SnackBarNotify.showSnackBar(context: context, message: 'Verification Completed', bgcolor: Colors.green, textColor: Colors.white);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          SnackBarNotify.showSnackBar(context: context, message: 'Invalid Phone Number', bgcolor: Colors.red, textColor: Colors.white);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        throw("Timeout");
      },
      forceResendingToken: _resendToken,
    );
    return true;
  }

   static Future<PhoneAuthCredential> submitOTP({
    required BuildContext context,
    required String otp,
    required List<TextEditingController> controllers,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otp);
    try { 
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        SnackBarNotify.showSnackBar(context: context, message: 'Invalid OTP', bgcolor: Colors.red, textColor: Colors.white);
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      SnackBarNotify.showSnackBar(context: context, message: 'Something Went Wrong!', bgcolor: Colors.amber, textColor: Colors.black);
      throw Exception(e);
    }
    if (context.mounted) {
      SnackBarNotify.showSnackBar(context: context, message: 'Verified OTP', bgcolor: Colors.green, textColor: Colors.white);
    }
    return credential;
  }
}