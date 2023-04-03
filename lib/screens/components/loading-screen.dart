// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Color(0xFF4F4F4F),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final count = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Positioned(
          top: screenHeight * 0.25,
          child: Column(
            children: const [
              Image(
                image: AssetImage('assets/icons/icon.png'),
                width: 250,
                height: 250,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.1,
          child: Row(
            children: const [
              LoadingIcon(),
              // for (int i = 0; i < 5; i++)
              //   Container(
              //     padding: const EdgeInsets.all(5.0),
              //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
              //     decoration: BoxDecoration(
              //       color: Color(0xFF4F4F4F),
              //       shape: BoxShape.circle,
              //     ),
              //   ),
            ],
          ),
        ),
      ]),
    );
  }
}
