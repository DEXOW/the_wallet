import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class QRCodeWidget extends StatefulWidget {
  final String jsonData;

  const QRCodeWidget(this.jsonData, {super.key});

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  late String jsonString;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      data: widget.jsonData,
      barcode: Barcode.qrCode(),
      color: Colors.black,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(5),
      width: 200,
      height: 200,
    );
  }
}
