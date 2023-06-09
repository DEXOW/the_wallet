import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;

  @override
  Widget build(BuildContext context){
    return const Center(child: Text('Wallet Screen'),);
  }
}