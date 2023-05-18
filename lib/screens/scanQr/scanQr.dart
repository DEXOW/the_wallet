// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeWidget extends StatefulWidget {
  ScanQrCodeWidget({Key? key}) : super(key: key);

  @override
  State<ScanQrCodeWidget> createState() => _scanqrcodewidgetstate();
}

class _scanqrcodewidgetstate extends State<ScanQrCodeWidget> {
  // Create an instance of QRViewController
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  late String? scannedData = '';

  // Function to handle QR scan results
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code data here
      setState(() {
        scannedData = scanData.code;
      });
      // Close the scanner after successful scan
      controller.pauseCamera();
      controller.dispose();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenHeight =
                constraints.maxHeight; //Get the height of the safe area
            double screenWidth =
                constraints.maxWidth; // Get the width of the safe area
            double qrSize = screenWidth * 0.7; // Adjust the size of the QR code widget
            return Stack(children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Center(
                    //   child: SizedBox(
                    //     height: 250, // Set a specific height
                    //     width: 250, // Set a specific width
                    //     child: QRView(
                    //         key: qrKey, onQRViewCreated: _onQRViewCreated),
                    //   ),
                    // ),

                    Center(
                      child: Container(
                        height: qrSize,
                        width: qrSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Customize the border color
                            width: 2.0, // Customize the border width
                          ),
                        ),
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Scanned QR Code Data:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      scannedData ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
