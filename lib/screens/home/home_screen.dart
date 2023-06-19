import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;

  @override
  Widget build(BuildContext context){
    return const Center(child: Text('Home Screen'),);
  }
}