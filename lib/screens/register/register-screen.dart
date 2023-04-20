// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<int> validity_arr = [0,0,0,0];
  final fName = TextEditingController();
  final lName = TextEditingController();

  // void initState() {
  //   super.initState();
  //   validity_arr = [0,0,0,0];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
            double screenHeight = constraints.maxHeight; // Get the height of the safe area
            double screenWidth = constraints.maxWidth; // Get the width of the safe area

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox( //SizedBox to set the height and width of the Page
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            style: ButtonStyle(
                              //Remove hover effects
                              overlayColor: MaterialStateProperty.all<Color>(
                                const Color(0x00000000),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            child: Image(
                              image: AssetImage('assets/icons/icon.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container( //Middle section
                      height: screenHeight * 0.8,
                      child: LayoutBuilder(
                        builder:(BuildContext context, BoxConstraints constraints){
                          if (validity_arr[0] == 0){
                            return view1();
                          } else if (validity_arr[1] == 0){
                            return view2();
                          } else if (validity_arr[2] == 0){
                            return view3();
                          } else if (validity_arr[3] == 0){
                            return view4();
                          } else {
                            return Container();
                          }
                        }
                      )
                    ),
                        // Container( //Middle section
                        //   height: screenHeight * 0.8,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(top: 10),
                        //         child: Text(
                        //           'Sign Up',
                        //           style: TextStyle(
                        //             fontSize: 30,
                        //             fontWeight: FontWeight.bold,
                        //             fontFamily: 'Inter',
                        //             color: Color(0xE608B4F8)
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(top: 70),
                        //         child: SizedBox(
                        //           width: 230.0,
                        //           child: TextFormField(
                        //             controller: fName,
                        //             decoration: const InputDecoration(
                        //               border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        //                 borderSide: BorderSide(
                        //                   style: BorderStyle.none,
                        //                   width: 0,
                        //                 ),
                        //               ),
                        //               filled: true,
                        //               contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                        //               hintText: 'First Name',
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 10),
                        //         child: SizedBox(
                        //           width: 230.0,
                        //           child: TextFormField(
                        //             controller: lName,
                        //             decoration: const InputDecoration(
                        //               border: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.all(Radius.circular(50.0)),
                        //                 borderSide: BorderSide(
                        //                   style: BorderStyle.none,
                        //                   width: 0,
                        //                 ),
                        //               ),
                        //               filled: true,
                        //               contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                        //               hintText: 'Last Name',
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(top: 40),
                        //         child: TextButton(
                        //           onPressed: () {
                        //             if (fName.text == '' && lName.text == '') {
                        //               setState(() {
                        //                 validity_arr[0] = 0;
                        //               });
                        //             } else {
                        //               setState(() {
                        //                 validity_arr[0] = 1;
                        //               });
                        //             }
                        //           },
                        //           style: ButtonStyle(
                        //             backgroundColor: MaterialStateProperty.all<Color>(
                        //               const Color(0xE61469EF),
                        //             ),
                        //             shape:
                        //                 MaterialStateProperty.all<RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(50.0),
                        //               ),
                        //             ),
                        //             fixedSize: MaterialStateProperty.all<Size>(
                        //               const Size(230.0, 50.0),
                        //             ),
                        //           ),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text(
                        //                 'Next',
                        //                 style: TextStyle(
                        //                   fontSize: 16.0,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontFamily: 'Inter',
                        //                   color: Color(0xFFFFFFFF),
                        //                 ),
                        //               ),
                        //               Container(
                        //                 margin: EdgeInsets.only(left: 10),
                        //                 child: Icon(
                        //                   Icons.arrow_forward_ios,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                    Container( //Bottom Section
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text(
                              'Legal',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Color(0x8FCDCDCD),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Color(0x8FCDCDCD),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ) 
      ),
    );
  }

  Widget view1(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Color(0xE608B4F8)
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 70),
          child: SizedBox(
            width: 230.0,
            child: TextFormField(
              controller: fName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                hintText: 'First Name',
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 230.0,
            child: TextFormField(
              controller: lName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0),
                hintText: 'Last Name',
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: TextButton(
            onPressed: () {
              // if (fName.text == '' && lName.text == '') {
              //   setState(() {
              //     validity_arr[0] = 0;
              //   });
              // } else {
              //   setState(() {
              //     validity_arr[0] = 1;
              //   });
              // }
              setState(() {
                validity_arr[0] = 1;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xE61469EF),
              ),
              shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                const Size(230.0, 50.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget view2(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Color(0xE608B4F8)
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Color(0x5E606060),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(left: 5),
                  icon: Icon(Icons.arrow_back_ios),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  style: ButtonStyle(
                    //Remove hover effects
                    overlayColor: MaterialStateProperty.all<Color>(
                      const Color(0x00000000),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      validity_arr[0] = 0;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    validity_arr[1] = 1;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xE61469EF),
                  ),
                  shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(230.0, 50.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget view3(){
    return Container();
  }
  Widget view4(){
    return Container();
  }
}