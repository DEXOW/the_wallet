import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/Settings Main/Settings_Main.dart';
import 'package:the_wallet/Screens/Edit Email/Edit_Email.dart';
import 'package:the_wallet/Screens/Edit Phone Number/Edit_Phone_Number.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        TextEditingController(text: "John");
    TextEditingController lastNameController =
        TextEditingController(text: "Doe");
    TextEditingController emailController =
        TextEditingController(text: "johndoe@gmail.com");
    TextEditingController phoneNumberController =
        TextEditingController(text: "+940778880661");
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, left: 24),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: closeColor,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: secondaryColor,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Image(
                            image: AssetImage('assets/icons/profile.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: const Image(
                                image: AssetImage('assets/icons/edit.jpeg'),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: const Text(
                        "E3422089-U7G11C",
                        style: TextStyle(
                          color: Color(0xAA424242),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Text(
                          'First Name',
                          style: TextStyle(
                            color: tertiraryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: firstNameController,
                              style: const TextStyle(
                                color: tertiraryColor,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          const Text(
                            'Last Name',
                            style: TextStyle(
                              color: tertiraryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: lastNameController,
                                style: const TextStyle(
                                  color: tertiraryColor,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                                textAlign: TextAlign.right,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const EditEmail(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = const Offset(0, 0.0);
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: tertiraryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: emailController,
                                style: const TextStyle(
                                  color: tertiraryColor,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                                textAlign: TextAlign.right,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SettingsOne(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = const Offset(0, 0.0);
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 150),
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                color: tertiraryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: phoneNumberController,
                                  style: const TextStyle(
                                    color: tertiraryColor,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: closeColor,
                        ),
                        width: 45,
                        height: 45,
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const EditPhoneNumber(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(-1.0, 0.0);
                                    var end = const Offset(0, 0.0);
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: secondaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(202, 45)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0x6024FF00)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
