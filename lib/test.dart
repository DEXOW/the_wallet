// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// import 'package:the_wallet/screens/account/userDataProvider.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   TestState createState() => TestState();
// }

// class TestState extends State<Test> {
//   bool _isLoading = true;
//   late UserDataProvider _userDataProvider;

//   @override
//   void initState() {
//     super.initState();
//     _userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
//     testEmailPasswordSignIn('manethweerasinghe@gmail.com', 'Maneth1234');
//   }

//   Future<void> testEmailPasswordSignIn(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Retrieve user data from Firestore
//       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();

//       // Update user data in provider
//       if (userSnapshot.exists) {
//         Map<String, dynamic>? userData =
//             userSnapshot.data() as Map<String, dynamic>?;
//         if (userData != null) {
//           _userDataProvider.userData.setData(
//               '${userData['fname']}',
//               '${userData['lname']}',
//               '${userData['email']}',
//               '${userData['phoneNo']}');
//         }
//       } else {
//         print('User data not found in Firestore.');
//       }
//     } on FirebaseAuthException catch (e) {
//       print('FirebaseAuthException: ${e.message}');
//     } on FirebaseException catch (e) {
//       print('FirebaseException: ${e.message}');
//     } catch (e) {
//       print('Error: ${e}');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Center(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('First Name: ${_userDataProvider.userData.fname}'),
//                   Text('Last Name: ${_userDataProvider.userData.lname}'),
//                   Text('Email: ${_userDataProvider.userData.email}'),
//                   Text('Phone Number: ${_userDataProvider.userData.phoneNo}'),
//                 ],
//               ),
//           ),
//     );
//   }
// }
