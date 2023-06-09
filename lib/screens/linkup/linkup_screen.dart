import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';

class LinkUpScreen extends StatefulWidget {
  const LinkUpScreen({super.key});
  
  @override
  State<LinkUpScreen> createState() => _LinkUpScreenState();
}

class _LinkUpScreenState extends State<LinkUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;

  @override
  Widget build(BuildContext context){
    return const Center(child: Text('Linkup Screen'),);
  }
}