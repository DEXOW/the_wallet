import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
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
    required context,
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
    try{
      await firestore.collection('users').doc(user!.uid).set({
        'fname': fname.trim(),
        'lname': lname.trim(),
        'email': email.trim(),
        'dobDate': dobDate.trim(),
        'dobMonth': dobMonth.trim(),
        'dobYear': dobYear.trim(),
        'phoneNoCode': phoneNoCode.trim(),
        'phoneNo': phoneNo.trim(),
      }).then((value) async {

        await firestore.collection('users').doc(user!.uid).collection('cards').doc('socialCard').set({
          'cardID': firestore.collection('users').doc().id,
          'fname': fname.trim(),
          'lname': lname.trim(),
          'career': '',
          'age': DateTime(DateTime.now().year - DateTime.parse('$dobYear-$dobMonth-$dobDate').year).year.toString(),
          'email': email.trim(),
          'phoneNo': phoneNoCode.trim() + phoneNo.trim(),
          'linkedin': '',
          'twitter': '',
          'facebook': '',
          'instagram': '',
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception(e);
    }
    return user;
  }

  static Future<bool> verifyPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
    // required Function onCodeSent,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification Completed'),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'The provided phone number is not valid.',
              textAlign: TextAlign.center,
            ),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Invalid OTP',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          )
        );
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        )
      );
      throw Exception(e);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'OTP Verified',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      )
    );
    return credential;
  }
}