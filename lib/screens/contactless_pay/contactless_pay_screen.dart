import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';

class ContactlessPayScreen extends StatefulWidget {
  const ContactlessPayScreen({super.key});
  
  @override
  State<ContactlessPayScreen> createState() => _ContactlessPayScreenState();
}

class _ContactlessPayScreenState extends State<ContactlessPayScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;

  @override
  Widget build(BuildContext context){
    return const Center(child: Text('Contactless Pay Screen'),);
  }
}