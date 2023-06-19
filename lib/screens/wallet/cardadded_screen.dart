import 'package:flutter/material.dart';
import 'package:the_wallet/screens/wallet/wallet_screen.dart';
import 'package:the_wallet/constants.dart';

class CardAddedScreen extends StatefulWidget {
  @override
  _CardAddedScreenState createState() => _CardAddedScreenState();
}

class _CardAddedScreenState extends State<CardAddedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Card Added',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your card has been added to your wallet.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // add function
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor.withOpacity(
                    0.62), // Set the button color to dark blue with opacity
                onPrimary: Colors.white, // Set the text color to white
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Round the button corners
                ),
                minimumSize:
                    const Size(200, 50), // Adjust the button's width and height
                elevation: 0.0, // Remove the button's elevation
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0), // Adjust the button's padding
              ),
              child: Container(
                width: 200,
                child: const Center(
                  child: Text(
                    'Go to Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}