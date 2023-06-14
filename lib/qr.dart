import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatefulWidget {
  final jsonData;

  QRCodeWidget(this.jsonData);

  @override
  _QRCodeWidgetState createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  late String jsonString;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: widget.jsonData,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.white,
    );
  }
}
