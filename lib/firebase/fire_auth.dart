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
    required String confPassword,
    required String dobDate,
    required String dobMonth,
    required String dobYear,
    required String phoneNoCode,
    required String phoneNo,
    required String otp1,
    required String otp2,
    required String otp3,
    required String otp4,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName("$fname $lname");
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<bool> createUserWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account already exists for that email.'),
          ),
        );
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Timeout'),
          ),
        );
      },
    );
  }

  // void onCodeSent(String verificationId, int? resendToken) async {
  //   String smsCode = "221144";
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // }

//6F:73:70:5E:7F:A4:49:A4:40:59:EB:24:28:B7:2E:32:FD:80:28:FB

  static Future<void> updateUser({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required String confPassword,
    required String dobDate,
    required String dobMonth,
    required String dobYear,
    required String phoneNoCode,
    required String phoneNo,
    required String otp1,
    required String otp2,
    required String otp3,
    required String otp4,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    try {
      await user!.updateDisplayName("$fname $lname");
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}