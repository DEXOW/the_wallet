import 'package:flutter/material.dart';
import 'package:the_wallet/constants.dart';
import 'package:the_wallet/Screens/Edit Profile/Edit_Profile.dart';

class EditPhoneNumber extends StatelessWidget {
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  const EditPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.only(bottom: 210),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: const [
                          ClipRRect(
                            child: Image(
                              image: AssetImage('assets/icons/profile.png'),
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
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          SizedBox(width: 30),
                          Text(
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
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                style: TextStyle(
                                  color: tertiraryColor,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          children: const [
                            SizedBox(width: 30),
                            Text(
                              'Verify Email',
                              style: TextStyle(
                                color: tertiraryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  style: TextStyle(
                                    color: tertiraryColor,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(256, 37)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0x80A1A1A1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Request OTP",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "OTP",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.5),
                          Row(
                            children: List.generate(
                              4,
                              (index) => const Padding(
                                padding: EdgeInsets.only(right: 12.5),
                                child: SizedBox(
                                  width: 30,
                                  child: TextField(
                                    maxLength: 1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding:
                                          EdgeInsets.only(bottom: -10),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40, left: 15),
                            child: const Text(
                              "60s",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 10,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                                      const EditProfilePage(),
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
