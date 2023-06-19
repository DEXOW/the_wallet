import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wallet/data_classes/user_data.dart';
import 'package:the_wallet/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ValueNotifier<bool> updateNavbar = ValueNotifier(false);
  late UserDataProvider userDataProvider;
  late GlobalProvider globalProvider;
  List<Widget> settingsNav = [];
  late ValueNotifier<Widget> settingsNavListner = ValueNotifier(main());

  bool showSecondScreen = false;
  //---------------------
  TextEditingController textEditingController = TextEditingController();
  double rating = 0.0;

  void submitFeedback() {
    // Reset the text area and rating bar
    setState(() {
      textEditingController.text = '';
      rating = 0.0;
    });
    //-----------------------
  }

  @override
  void initState() {
    super.initState();
    settingsNav.add(main());
    settingsNavListner.value = main();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ValueListenableBuilder(
                valueListenable: settingsNavListner,
                builder: (context, value, child) {
                  return settingsNav.last;
                });
          },
        ));
  }

  Widget main() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: const Text(
            "Settings",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  settingsNav.add(manageWallet());
                  settingsNavListner.value = manageWallet();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/manage-wallet.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Manage Wallet',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/log-book.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Log Book',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/notifications.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Notification settings',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 60), // Add spacing between the buttons
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => FAQScreen()));
                  setState(() {
                    settingsNav.add(FAQ());
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/faq.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'FAQ',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20), // Add spacing between the buttons
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                  setState(() {
                    settingsNav.add(contactUs());
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/contact-us.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Contact us',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20), // Add spacing between the buttons
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    settingsNav.add(termsConds());
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/terms-conditions.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20), // Add spacing between the buttons
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    settingsNav.add(privacyPolicy());
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/privacy-policy.png',
                            width: 20,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

//-------------------------------------------------------------------------------------------------------------------

  Widget manageWallet() {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: const Row(
            children: [
               Expanded(
                child: Text(
                  "Manage Wallet",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
      Column(children: [
        Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              settingsNav.add(sendFeeback());
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 192, 192, 192),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/feedback.png',
                      width: 20,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Send Feedback',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          height: 45,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: const Color.fromARGB(255, 192, 192, 192),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/wallet-appearence.png',
                        width: 20,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Wallet Appearence',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          height: 45,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: const Color.fromARGB(255, 192, 192, 192),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/wallet-appearence.png',
                        width: 20,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Security Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
        )
      ]),
    ]);
  }

//-------------------------------------------------------------------------------------------------------------------------------------------
  // ignore: non_constant_identifier_names
  Widget FAQ() {
    return Stack(children: [
      Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Row(
            children: [
               Expanded(
                child: Text(
                  "FAQ",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Text(
          "We're happy to help.",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        const CollapsiblePanel(
          title: 'How to set up a digital wallet account?',
          content:
              'To set up a digital wallet account, create an account using your personal information, and link your preferred payment methods, such as a credit card or bank account.',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title: 'Is it safe to use a digital wallet app to make payments?',
          content:
              "Yes, digital wallet apps use encryption and other security measures to protect your payment information and prevent unauthorized access. However, it's important to use strong passwords, keep your device and app up to date, and be cautious when using public Wi-Fi networks.",
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title:
              'What fees are associated with using a digital wallet app?',
          content:
              'Fees associated with using a digital wallet app can vary depending on the provider and the type of transaction. Some providers may charge fees for adding or withdrawing funds, while others may charge transaction fees for purchases.',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title: 'What happens if my phone is lost or stolen?',
          content:
              'If your phone is lost or stolen, you should immediately contact your digital wallet provider to report the issue and disable your account. Many providers offer additional security features like remote wipe and device tracking to help protect your information.',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title:
              'How do I update my personal information in the digital wallet app?',
          content:
              'You can typically update your personal information in the digital wallet app settings, which may include information like your name, address, and contact information.',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title: 'What happens if a transaction fails or is declined?',
          content:
              'If a transaction fails or is declined, you should contact your digital wallet provider to determine the cause of the issue and resolve any potential issues with your account or payment method.',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title:
              'What types of payment methods can I link to my digital wallet account?',
          content:
              'Most digital wallet apps allow you to link a variety of payment methods, including credit cards, debit cards, and bank accounts. ',
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title: 'Can I use my digital wallet app to pay bills?',
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title:
              'How do I view my transaction history in the digital wallet app?',
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title:
              'How do I add and remove cards from the digital wallet app?',
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
        ),
        const SizedBox(height: 10),
        const CollapsiblePanel(
          title: 'What happens if my phone is lost or stolen?',
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
        ),
        const SizedBox(height: 50),
          ]),
        ),
      ]),
    ]);
  }
//------------------------------------------------------------------------------------------------------------------------------------------------
  Widget contactUs() {
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
      Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
      Image.asset(
        'assets/icons/contact us 1.png',
        width: 500,
        height: 200,
      ),
      const SizedBox(height: 16.0),
      const Text(
        "Call us or send a message and we'll respond as soon as possibile.",
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 50),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name *',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          TextField(
            controller: textFieldController1,
            maxLines: null,
            decoration: const InputDecoration(
                ),
          ),
        ],
      ),
      const SizedBox(height: 50),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email *',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          TextField(
            controller: textFieldController2,
            maxLines: null,
            decoration: const InputDecoration(
                //hintText: 'Enter text',
                ),
          ),
        ],
      ),
      const SizedBox(height: 50),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Message',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          TextField(
            controller: textFieldController3,
            maxLines: null,
            decoration: const InputDecoration(
                ),
          ),
        ],
      ),
      const SizedBox(height: 40.0),
      SizedBox(
        width: 200,
        height: 40,
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 50),
        ]),
      ),
    ]);
  }

  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();
  void _submitForm() {
    textFieldController1.clear();
    textFieldController2.clear();
    textFieldController3.clear();
  }
// ----------------------------------------------------------------------------------------------------------------------
  Widget termsConds() {
    return Stack(children: [
      Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
        Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Welcome to "The Wallet", a digital wallet app that allows you to store your national ID card, university ID card, credit card, and debit card information in one place for easy access and payment. These terms and conditions ("Terms") govern your use of "The Wallet". By using "The Wallet", you agree to these Terms. If you do not agree to these Terms, do not use "The Wallet".',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children:  [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Use of Wallet',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '"The Wallet" is provided to you for personal use only. You agree to use "The Wallet" in compliance with all applicable laws and regulations. You are responsible for maintaining the confidentiality of your login information and for all activities that occur under your account.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Privacy',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'We take your privacy very seriously. Please refer to our privacy policy for information about how we collect, use, and share information about you when you use "The Wallet".',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
               Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Termination',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "The App provider reserves the right to suspend or terminate a user's account or access to the App at any time and for any reason. Users may terminate their account by following the instructions provided in the App",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
               Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'User Responsibilities',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Users agree to use the App in accordance with applicable laws, regulations, and these terms and conditions. Users agree not to use the App for any unlawful, fraudulent, or unauthorized purposes.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
          ]),
        ),
      ]),
    ]);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------
  Widget privacyPolicy() {
    return Stack(children: [
      Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
        Container(
            margin: const EdgeInsets.only(bottom: 80),
            width: 350,
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'We take your privacy very seriously and are committed to protecting your personal information. This privacy policy explains how we collect, use, and share information about you when you use our digital wallet app, "The Wallet".',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Information We Collect',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Personal Information: When you create an account and use our App, we may collect personal information such as your name, email address, phone number, and billing address. We do not collect or store your card numbers or security codes; instead, we securely tokenize and encrypt this information.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Data Security',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'We take reasonable measures to protect your personal information and card details from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the Internet or electronic storage is completely secure. Therefore, while we strive to protect your information, we cannot guarantee its absolute security.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Data Retention',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "We retain your personal information and card details only for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(9.0),
          width: 350,
          child: const Column(
            children:  [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Changes to this Privacy Policy',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "We may update this Privacy Policy from time to time. Any changes will be effective immediately upon posting the revised policy in the App",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
          ]),
        ),
      ]),
    ]);
  }
  //---------------------------------------------------------------------------------------------------------------------

  Widget sendFeeback() {
    return Stack(children: [
      Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  "Send Feedback",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
        const Text(
          'Say what you think about this app',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        TextField(
          controller: textEditingController,
          maxLines: null,
          decoration: const InputDecoration(
              // hintText: 'Enter text...',
              ),
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
          ), // Replace with your desired font size
        ),
        const SizedBox(height: 50),
        const Text(
          'How was your experience with us?',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.star),
              color: rating >= 1 ? Colors.amber : Colors.grey,
              onPressed: () {
                setState(() {
                  rating = 1.0;
                });
              },
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.star),
              color: rating >= 2 ? Colors.amber : Colors.grey,
              onPressed: () {
                setState(() {
                  rating = 2.0;
                });
              },
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.star),
              color: rating >= 3 ? Colors.amber : Colors.grey,
              onPressed: () {
                setState(() {
                  rating = 3.0;
                });
              },
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.star),
              color: rating >= 4 ? Colors.amber : Colors.grey,
              onPressed: () {
                setState(() {
                  rating = 4.0;
                });
              },
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.star),
              color: rating >= 5 ? Colors.amber : Colors.grey,
              onPressed: () {
                setState(() {
                  rating = 5.0;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: submitFeedback,
          child: const Text('Submit'),
        ),
      ]),
    ]);
  }
}
//------------------------------------------------------------------------------------
class CollapsiblePanel extends StatefulWidget {
  final String title;
  final String content;

  const CollapsiblePanel({super.key, 
    required this.title,
    required this.content,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CollapsiblePanelState createState() => _CollapsiblePanelState();
}

class _CollapsiblePanelState extends State<CollapsiblePanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Column(
        children: [
          ListTile(
            title: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: const Color.fromARGB(255, 192, 192, 192),
                width: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: const Color.fromARGB(141, 192, 192, 192),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
