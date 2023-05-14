// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  String? hintLabel;
  TextEditingController? controller;
  InputBox({Key? key, this.hintLabel, required this.controller}) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Positioned(
        top: 0,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.hintLabel,
            ),
          ),
        ),
      ),]
    );
  }
}