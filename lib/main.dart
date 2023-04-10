import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wallet',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      home: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}